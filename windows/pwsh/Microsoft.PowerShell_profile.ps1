# Oh my posh
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\shawn.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\shawn-solarized.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\shawn-half-life.omp.json" | Invoke-Expression

# PSReadLine (Terminal autocompletation)
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Alias
Set-Alias ll ls
Set-Alias g git
