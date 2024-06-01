Param(
    [string]$Target
)

$Targets = @('help', 'alacritty', 'symlink', 'all')
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
        Write-Host "'$Alacritty_File' not found. Creating a symlink..."
        New-Item -Path $Alacritty_File -ItemType SymbolicLink -Value "$PWD\.config\alacritty\alacritty.toml"
    }
}

function PS_SetupSymlinks {
        New-Item -Path "$PWD\.gitconfig" -ItemType SymbolicLink -Value "$env:HOMEPATH\.gitconfig"
}

switch -Exact ($Target) {
    { $_ -eq "help" } {
        Write-Host "Usage: .\setup.ps1 -Target <target>"
        Write-Host "Available targets: $ListOfTargets"
    }
    { $_ -eq "alacritty" } { PS_SetupAlacrittyConfigFile }
    { $_ -eq "symlink" } { PS_SetupSymlinks }
    { $_ -eq "all" } {
        PS_InstallModules
        PS_SetupAlacrittyConfigFile
        PS_SetupSymlinks
    }
    Default {
        Write-Host "Unrecognized target. Available targets: $ListOfTargets"
    }
}
