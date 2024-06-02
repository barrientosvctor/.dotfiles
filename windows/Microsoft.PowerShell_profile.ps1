function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function admin {
    if ($PSVersionTable.PSEdition -eq "Core") {
        $powershell_cmd = "pwsh.exe"
    } elseif ($PSVersionTable.PSEdition -eq "Desktop") {
        $powershell_cmd = "powershell.exe"
    }

    [string] $command = $args -join " "

    if ($args.Count -gt 0) {
        Start-Process "$PSHOME\$powershell_cmd" -Verb RunAs -ArgumentList "-NoLogo","-Interactive","-Command","$command; pause"
    } else {
        Start-Process "$PSHOME\$powershell_cmd" -Verb RunAs
    }
}

# ======= MODULE IMPORTS =======

# If it's running on powershell not core, with version less than 7 and exists a module named 'PSReadLine' installed.
if (-not ($PSVersionTable.PSEdition -eq "Core" -and $PSVersionTable.PSVersion.Major -ge 7 -and $PSVersionTable.PSVersion.Minor -ge 4)) {
    if ($null -ne (Get-Module -Name PSReadLine)) {
        Import-Module PSReadLine
    }
}

# ======= MODULE CONFIG =======
# PSReadLine (Terminal autocompletation)
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# ======= ALIASES =======
Set-Alias -Name l -Value ls
Set-Alias -Name g -Value git
Set-Alias -Name v -Value nvim
Set-Alias -Name df -Value Get-Volume
Set-Alias -Name sudo -Value admin
Set-Alias -Name su -Value admin
