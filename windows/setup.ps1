Param(
    # Target passed as input.
    ##! Modify the help message when a new target is created.
    [Parameter(Mandatory, HelpMessage = 'Targets: all, help, modules, alacritty, symlink' )]
    [string]$Target
)

[int] $processCount = 0

##! Modify this hash table every time a new target is needed to create.
# 'targetName' = 'FunctionName'
# When the input matches with some key in the hash table, the function name passed as value will be invoke.
$hashTableTargets = @{
    'all' = "PS_InvokeAllTargets";
    'help' = "PS_ShowScriptInfo";
    'modules' = "PS_InstallModules";
    'alacritty' = "PS_SetupAlacrittyConfigFile";
    'symlink' = "PS_SetupSymlinks";
}

# Formats the hash table to a comprehensible string
$availableTargets = $hashTableTargets.Keys.ForEach({"`n-> $PSItem"})

# Used to when `all` target is matched.
##! Modify it when a new target function is created.
function PS_InvokeAllTargets {
    PS_InstallModules
    PS_SetupAlacrittyConfigFile
    PS_SetupSymlinks
}

# Used to show the amount of changes made in a target.
function PS_CountChanges {
    param(
        [Parameter(Mandatory)]
        [int]$Count,

        [Parameter(Mandatory)]
        [string]$ProcessName
     )

    if ($Count -eq 0) {
        Write-Host "--> There were no changes in $ProcessName process. <--"
    } elseif ($Count -gt 0) {
        Write-Host "--> $ProcessName process successfully executed with $Count changes. <--"
    } else {
        Write-Host "--> $ProcessName process successfully executed with unknown number of changes. <--"
    }
}

function PS_InstallModules {
    Write-Host "Installing PSReadLine..."
    Install-Module PSReadLine
    Install-Module "--> PSReadLine installed."
    PS_CountChanges -Count -1 -ProcessName "Modules"
}

# This function assumes you're located in dotfiles's root directory
function PS_SetupAlacrittyConfigFile {
    [string]$Alacritty_Path = "$env:APPDATA\alacritty"
    [string]$Alacritty_File = "$env:APPDATA\alacritty\alacritty.toml"

    if (-Not (Test-Path -Path $Alacritty_Path)) {
        Write-Host "'$Alacritty_Path' not found. Creating..."
        New-Item -ItemType Directory -Path $Alacritty_Path
        $processCount = $processCount + 1
    }

    if (-Not (Test-Path -Path "$Alacritty_Path\alacritty.toml")) {
        Write-Host "'$Alacritty_File' not found. Creating a symlink..."
        New-Item -Path $Alacritty_File -ItemType SymbolicLink -Value "$PWD\.config\alacritty\alacritty.toml"
        $processCount = $processCount + 1
    }

    PS_CountChanges -Count $processCount -ProcessName "Alacritty"
    $processCount = 0
}

function PS_SetupSymlinks {
    New-Item -Path "$env:HOMEPATH\.gitconfig" -ItemType SymbolicLink -Value "$PWD\.gitconfig"
}

# Used to when `help` target is matched.
function PS_ShowScriptInfo {
    Write-Host "Usage: .\setup.ps1 -Target <target>"
    Write-Host "Available targets: $availableTargets"
}

if ($hashTableTargets.ContainsKey($Target)) {
    Invoke-Expression -Command $hashTableTargets[$Target]
} else {
    Write-Host "Unrecognized target. Available targets: $availableTargets"
}
