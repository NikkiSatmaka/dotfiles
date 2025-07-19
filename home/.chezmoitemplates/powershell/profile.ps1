
$ENV:STARSHIP_CONFIG = "$HOME\config\starship\config.toml"

# # Chocolatey profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }

# Starship init
if (Get-Command starship -errorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}
