import os
from pathlib import Path
import subprocess
import tempfile
import time
import unittest

ROOT = Path(__file__).resolve().parents[1]
SHELL = ROOT / "home/private_dot_config/private_shell"


class CompletionCacheTests(unittest.TestCase):
    def test_cli_aliases_load_without_running_completion_generators(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name in ("docker", "kubectl", "podman", "uv"):
                tool = root / name
                tool.write_text('#!/bin/sh\nprintf called >> "$CALLS"\nexit 1\n')
                tool.chmod(0o755)
            result = subprocess.run(
                ["zsh", "-f", "-c", '''
compdef() { :; }
source "$1"
[[ ${aliases[dps]} == 'docker ps' ]] || exit 10
[[ ${aliases[k]} == kubectl ]] || exit 11
[[ ${aliases[pr]} == 'podman container run' ]] || exit 12
[[ ${aliases[uva]} == 'uv add' ]] || exit 13
(( $+functions[kj] && $+functions[kres] )) || exit 14
''', "test", str(ROOT / "home/private_dot_config/private_shell/private_alias.d/private_cli-aliases.zsh")],
                env=dict(os.environ, PATH=f"{root}:{os.environ['PATH']}", CALLS=str(root / "calls")),
                text=True, capture_output=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertFalse((root / "calls").exists())

    def test_omp_cold_and_warm_start_do_not_depend_on_cached_eval(self):
        for shell in ("bash", "zsh"):
            with self.subTest(shell=shell), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                tool = root / "omp"
                tool.write_text("#!/bin/sh\nprintf 'call\\n' >> \"$CALLS\"\nprintf 'OMP_COMPLETION_LOADED=yes\\n'\n")
                tool.chmod(0o755)
                code = '''
cached-eval() { shift; "$@"; }
. "$1"
. "$2"
test "$OMP_COMPLETION_LOADED" = yes || exit 10
unset OMP_COMPLETION_LOADED
. "$2"
test "$OMP_COMPLETION_LOADED" = yes || exit 11
'''
                result = subprocess.run(
                    [shell, "-f" if shell == "zsh" else "--noprofile", "-c", code, "test",
                     str(SHELL / "private_lib.d/private_completions.sh"),
                     str(SHELL / f"private_shell-tools/omp/init.{shell}")],
                    env=dict(os.environ, PATH=f"{root}:{os.environ['PATH']}",
                             XDG_CACHE_HOME=directory, CALLS=str(root / "calls")),
                    text=True, capture_output=True)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stderr, "")
                self.assertEqual((root / "calls").read_text().splitlines(), ["call"])

    def test_refresh_keeps_identical_files_and_failed_generation_keeps_last_good_cache(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            tool = root / "generate"
            tool_code = "#!/bin/sh\nprintf 'call\\n' >> \"$CALLS\"\nprintf 'good\\n'\n"
            tool.write_text(tool_code)
            tool.chmod(0o755)
            cache = root / "completions/_test"
            env = dict(os.environ, PATH=f"{root}:{os.environ['PATH']}", CALLS=str(root / "calls"))
            command = ["sh", "-c", '. "$1"; cache_command_output "$2" generate',
                       "test", str(SHELL / "private_lib.d/private_completions.sh"), str(cache)]
            subprocess.run(command, env=env, check=True)
            before = cache.stat()
            directory_mtime = cache.parent.stat().st_mtime_ns
            subprocess.run(command, env=env | {"SHELL_COMPLETIONS_REFRESH": "1"}, check=True)
            self.assertEqual((before.st_mtime_ns, before.st_ino),
                             (cache.stat().st_mtime_ns, cache.stat().st_ino))
            self.assertEqual(directory_mtime, cache.parent.stat().st_mtime_ns)
            # An executable upgrade with identical output should regenerate once,
            # then remain warm without touching the completion file/directory.
            time.sleep(0.01)
            tool.write_text(tool_code + "# upgraded executable\n")
            subprocess.run(command, env=env, check=True)
            subprocess.run(command, env=env, check=True)
            self.assertEqual(len((root / "calls").read_text().splitlines()), 3)
            self.assertEqual(directory_mtime, cache.parent.stat().st_mtime_ns)
            tool.write_text("#!/bin/sh\nprintf 'broken\\n'\nexit 23\n")
            result = subprocess.run(command, env=env | {"SHELL_COMPLETIONS_REFRESH": "1"}, capture_output=True)
            self.assertNotEqual(result.returncode, 0)
            self.assertEqual(cache.read_text(), "good\n")
