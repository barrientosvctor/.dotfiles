Param(
    [string]$Target
)

$Targets = @('help', 'alacritty', 'all')
$ListOfTargets = $Targets.foreach({"`n-> $PSItem"})

if ($Target -eq "") {
    $Target = "all"
}

function PS_InstallModules {
    Write-Host "Installing PSReadLine..."
    Install-Module PSReadLine
}

# This function assumes you're located in dotfiles's root directory
function PS_SetupAlacrittyConfigFile {
    [string]$Alacritty_Path = "$env:APPDATA\alacritty"
    [string]$Alacritty_File = "$env:APPDATA\alacritty\alacritty.toml"

    if (-Not (Test-Path -Path $Alacritty_Path)) {
        Write-Host "'$Alacritty_Path' not found. Creating..."
        New-Item -ItemType Directory -Path $Alacritty_Path
    }

    if (-Not (Test-Path -Path "$Alacritty_Path\alacritty.toml")) {
        Write-Host "'$Alacritty_File' not found. Copying..."
        Copy-Item -Path "$PWD\.config\alacritty\alacritty.toml" -Destination $Alacritty_File
    }
}

switch -Exact ($Target) {
    { $_ -eq "help" } {
        Write-Host "Usage: .\setup.ps1 -Target <target>"
        Write-Host "Available targets: $ListOfTargets"
    }
    { $_ -eq "alacritty" } { PS_SetupAlacrittyConfigFile }
    { $_ -eq "all" } {
        PS_InstallModules
        PS_SetupAlacrittyConfigFile
    }
    Default {
        Write-Host "Unrecognized target. Available targets: $ListOfTargets"
    }
}
