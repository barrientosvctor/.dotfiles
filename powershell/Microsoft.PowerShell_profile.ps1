# Oh my posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\solarized.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\shawn.omp.json" | Invoke-Expression

# Icons
Import-Module Terminal-Icons

# PSReadLine (Terminal autocompletation)
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
