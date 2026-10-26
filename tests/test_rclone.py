import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class ShellUtilitiesTests(unittest.TestCase):
    def test_rclone_wrappers_preserve_transfer_failure(self):
        for script in (ROOT / "home/private_dot_local/private_bin").glob('*rclone*'):
            with self.subTest(script=script.name):
                content = script.read_text()
                if script.suffix == ".tmpl":
                    content = subprocess.run(["chezmoi", "execute-template"], input=content,
                                             text=True, capture_output=True, check=True).stdout
                result = subprocess.run(
                    ["bash", "--noprofile", "--norc", "-c",
                     'rclone() { return 23; }; read() { return 0; }; ' + content],
                    text=True, capture_output=True)
                self.assertEqual(result.returncode, 23, result.stderr)
