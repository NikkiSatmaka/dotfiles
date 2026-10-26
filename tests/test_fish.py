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
    @unittest.skipUnless(shutil.which("fish"), "Fish is not installed")
    def test_fish_imports_shared_environment_without_running_interactive_tools(self):
        with tempfile.TemporaryDirectory() as directory:
            config = Path(directory)
            shared = config / "shell"
            shared.mkdir()
            (shared / "env.sh").write_text(
                "export CHECK='line one\nline two=three'\nexport EMPTY=''\n")
            shutil.copyfile(SHELL / "private_env.fish", shared / "env.fish")
            tools = shared / "shell-tools/test"
            tools.mkdir(parents=True)
            (tools / "init.fish").write_text("echo unexpected-tool-output\n")
            result = subprocess.run(
                ["fish", "--no-config", "-c", '''
source $argv[1]
test "$CHECK" = "line one\nline two=three"; or exit 10
set -q EMPTY; or exit 11
test -z "$EMPTY"; or exit 12
''', str(ROOT / "home/private_dot_config/private_fish/private_config.fish")],
                env=dict(os.environ, XDG_CONFIG_HOME=directory), text=True, capture_output=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout, "")
