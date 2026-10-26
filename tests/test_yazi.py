"""Focused shell regressions. Run with: python3 -m unittest discover -s tests -v."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
SHELL = ROOT / "home/private_dot_config/private_shell"


class ShellTests(unittest.TestCase):
    def test_yazi_always_cleans_up_and_preserves_exit_status(self):
        for shell in ("bash", "zsh"):
            for mode in ("same", "empty", "change", "failure"):
                with self.subTest(shell=shell, mode=mode), tempfile.TemporaryDirectory() as directory:
                    work = Path(directory)
                    destination = work / "new directory"
                    destination.mkdir()
                    fake = work / "yazi"
                    fake.write_text('''#!/bin/sh
for arg do case "$arg" in --cwd-file=*) tmp=${arg#*=};; esac; done
printf '%s' "$tmp" > "$YAZI_RECORD"
case "$YAZI_MODE" in
  same) printf '%s' "$PWD" > "$tmp";;
  change) printf '%s' "$YAZI_DESTINATION" > "$tmp";;
  failure) exit 23;;
esac
''')
                    fake.chmod(0o755)
                    env = dict(os.environ, PATH=f"{work}:{os.environ['PATH']}",
                               TMPDIR=directory, YAZI_RECORD=str(work / "record"),
                               YAZI_MODE=mode, YAZI_DESTINATION=str(destination),
                               YAZI_PWD_RECORD=str(work / "pwd"),
                               XDG_CONFIG_HOME=directory, TERM="xterm-256color")
                    command = [shell, "-f" if shell == "zsh" else "--noprofile", "-c",
                               '. "$1"; y; code=$?; printf "%s" "$PWD" > "$YAZI_PWD_RECORD"; exit "$code"',
                               "test", str(SHELL / "private_functions.d/private_utils.sh")]
                    result = subprocess.run(
                        command,
                        env=env, cwd=directory, text=True, capture_output=True)
                    self.assertEqual(result.returncode, 23 if mode == "failure" else 0, result.stderr)
                    self.assertEqual((work / "pwd").read_text(), str(destination if mode == "change" else work))
                    self.assertFalse(Path((work / "record").read_text()).exists())

