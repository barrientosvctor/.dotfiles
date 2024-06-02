# If it's running on powershell not core, with version less than 7 and exists a module named 'PSReadLine' installed.
if (-not ($PSVersionTable.PSEdition -eq "Core" -and $PSVersionTable.PSVersion.Major -ge 7 -and $PSVersionTable.PSVersion.Minor -ge 4 -and ($null -ne (Get-Module -Name PSReadLine)))) {
    Import-Module PSReadLine
}

# PSReadLine (Terminal autocompletation)
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Alias
Set-Alias -Name l -Value ls
Set-Alias -Name g -Value git
Set-Alias -Name v -Value nvim

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
