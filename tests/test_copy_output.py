import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ShellUtilitiesTests(unittest.TestCase):
    def test_copy_output_accepts_command_arguments_and_preserves_failure(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            clipboard = root / "pbcopy"
            clipboard.write_text('#!/bin/sh\ncat > "$CLIPBOARD"\n')
            clipboard.chmod(0o755)
            for shell in ("bash", "zsh"):
                with self.subTest(shell=shell):
                    result = subprocess.run(
                        [shell, "-f" if shell == "zsh" else "--noprofile", "-c",
                         '. "$1"; copy_output printf "%s" "hello world" || exit 10; copy_output false',
                         "test", str(ROOT / "home/private_dot_config/private_shell/private_functions.d/private_utils.sh")],
                        env=dict(os.environ, PATH=f"{root}:{os.environ['PATH']}", CLIPBOARD=str(root / "clipboard")),
                        text=True, capture_output=True)
                    self.assertEqual(result.returncode, 1, result.stderr)
                    self.assertEqual((root / "clipboard").read_text(), "hello world")
