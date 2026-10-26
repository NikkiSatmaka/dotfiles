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
    def test_optional_source_skips_missing_but_reports_existing_errors(self):
        with tempfile.TemporaryDirectory() as directory:
            broken = Path(directory) / "broken.sh"
            broken.write_text("printf 'visible error\\n' >&2\nreturn 7\n")
            for shell in ("bash", "zsh"):
                with self.subTest(shell=shell):
                    result = subprocess.run(
                        [shell, "-f" if shell == "zsh" else "--noprofile", "-c",
                         '. "$1"; ssource "$2/missing.sh" || exit 10; ssource "$2/broken.sh"',
                         "test", str(SHELL / "private_lib.d/private_path.sh"), directory],
                        text=True, capture_output=True)
                    self.assertEqual(result.returncode, 7)
                    self.assertIn("visible error", result.stderr)
