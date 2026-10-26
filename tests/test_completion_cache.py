import os
from pathlib import Path
import subprocess
import tempfile
import time
import unittest

ROOT = Path(__file__).resolve().parents[1]
SHELL = ROOT / "home/private_dot_config/private_shell"


class CompletionCacheTests(unittest.TestCase):
    def test_upstream_aliases_are_cached_and_follow_plugin_updates(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            tool = root / "uv"
            tool.write_text("#!/bin/sh\nexit 0\n")
            tool.chmod(0o755)
            shared = root / "config/shell"
            shared.mkdir(parents=True)
            import shutil
            shutil.copyfile(SHELL / "private_generate-omz-aliases.zsh", shared / "generate-omz-aliases.zsh")
            plugin = root / "uv.plugin.zsh"
            plugin_code = 'printf "called\\n" >> "$CALLS"\nalias uva="uv add"\n'
            plugin.write_text(plugin_code)
            code = '''
. "$1"
. "$2"
. "$3"
fpath=("$4" $fpath)
compdef() { :; }
load_omz_aliases uv
load_omz_aliases uv
print -r -- "$aliases[uva]"
'''
            command = ["zsh", "-f", "-c", code, "test",
                       str(SHELL / "private_lib.d/private_completions.sh"),
                       str(SHELL / "private_lib.d/private_path.sh"),
                       str(SHELL / "private_lib.d/private_omz-aliases.zsh"), str(root)]
            env = dict(os.environ, PATH=f"{root}:{os.environ['PATH']}",
                       XDG_CONFIG_HOME=str(root / "config"), XDG_CACHE_HOME=str(root / "cache"),
                       CALLS=str(root / "calls"))
            first = subprocess.run(command, env=env, text=True, capture_output=True)
            self.assertEqual(first.returncode, 0, first.stderr)
            self.assertEqual(first.stdout.strip(), "uv add")
            self.assertEqual(len((root / "calls").read_text().splitlines()), 1)
            time.sleep(0.01)
            plugin.write_text(plugin_code.replace("uv add", "uv add --updated"))
            second = subprocess.run(command, env=env, text=True, capture_output=True)
            self.assertEqual(second.returncode, 0, second.stderr)
            self.assertEqual(second.stdout.strip(), "uv add --updated")
            self.assertEqual(len((root / "calls").read_text().splitlines()), 2)

    def test_omp_cold_and_warm_start_do_not_depend_on_cached_eval(self):
        for shell in ("bash", "zsh"):
            with self.subTest(shell=shell), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                tool = root / "omp"
                tool.write_text("#!/bin/sh\nprintf 'call\\n' >> \"$CALLS\"\nprintf 'OMP_COMPLETION_LOADED=yes\\n'\n")
                tool.chmod(0o755)
                code = '''
set -C
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
            command = ["sh", "-c", 'set -C; . "$1"; cache_command_output "$2" generate',
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
