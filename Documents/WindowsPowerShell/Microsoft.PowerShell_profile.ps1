
$ENV:STARSHIP_CONFIG = "$HOME\config\starship\config.toml"

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Starship init
if (Get-Command starship -errorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
if (Get-Command conda -errorAction SilentlyContinue) {
  (& "$HOME\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
}
#endregion


