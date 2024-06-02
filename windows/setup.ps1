Param(
    # Target passed as input.
    ##! Modify the help message when a new target is created.
    [Parameter(Mandatory, HelpMessage = 'Targets: all, help, modules, alacritty, symlink, fonts, profile' )]
    [string]$Target
)

# Ensure the script can run with elevated privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run this script as an Administrator!"
    break
}

[int] $processCount

##! Modify this hash table every time a new target is needed to create.
# 'targetName' = 'FunctionName'
# When the input matches with some key in the hash table, the function name passed as value will be invoke.
$hashTableTargets = @{
    'all' = "Dotfiles_PS_InvokeAllTargets";
    'help' = "Dotfiles_PS_ShowScriptInfo";
    'modules' = "Dotfiles_PS_InstallModules";
    'alacritty' = "Dotfiles_PS_SetupAlacrittyConfigFile";
    'symlink' = "Dotfiles_PS_SetupSymlinks";
    'fonts' = "Dotfiles_PS_InstallFonts";
    'profile' = "Dotfiles_PS_SetupPSProfile";
}

# Formats the hash table to a comprehensible string
$availableTargets = $hashTableTargets.Keys.ForEach({"`n-> $PSItem"})

# Used to when `all` target is matched.
##! Modify it when a new target function is created.
function Dotfiles_PS_InvokeAllTargets {
    Dotfiles_PS_InstallModules
    Dotfiles_PS_InstallFonts
    Dotfiles_PS_SetupAlacrittyConfigFile
    Dotfiles_PS_SetupPSProfile
    Dotfiles_PS_SetupSymlinks
}

# Used to show the amount of changes made in a target.
function Dotfiles_PS_CountChanges {
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

# This function should only be used into this script file.
# This is the base function to install fonts.
# The function assumes you are running the script on root dotfiles path.
# -- Permissions of administrator required: NO
function Internal_Dotfiles_PS_FontInstaller {
    Param(
        [Parameter(Mandatory, HelpMessage = "Type the URI of the font.")]
        [string] $Uri,
        [Parameter(Mandatory, HelpMessage = "Type the name you want for the resulting font's files and folders")]
        [string] $FontName,
        [Parameter(Mandatory=$false, HelpMessage = "Type the path where fonts are located. The input will be concatenated with the dotfiles's .fonts folder")]
        [string] $FontsPath,
        [Parameter(Mandatory=$false, HelpMessage = "Type a string of pattern of files you want to include separed by comma (,)")]
        [string[]] $Includes,
        [Parameter(Mandatory=$false, HelpMessage = "Type a string of pattern of files you want to exclude separed by comma (,)")]
        [string[]] $Excludes
     )

    # Special folders in powershell: https://richardspowershellblog.wordpress.com/2008/03/20/special-folders/
    $SystemFontPath = (New-Object -ComObject Shell.Application).Namespace(0x14)

    $DotfilesFontFolder = "$PWD\.fonts"
    $CompressFontFileExtension = $Uri.Split(".")[-1] # Go to the last element in the array.
    $CompressFontFile = "$DotfilesFontFolder\$FontName.$CompressFontFileExtension"

    $ResultingFontFolder = "$DotfilesFontFolder\$FontName"
    $FontPathChildItem = "$ResultingFontFolder\*"

    if (-not ($FontsPath -eq "")) {
        $FontPathChildItem = "$ResultingFontFolder\$FontsPath\*"
    }

    if (-Not (Test-Path -Path $DotfilesFontFolder)) {
        New-Item -ItemType Directory -Path $DotfilesFontFolder
        $processCount = $processCount + 1
    }

    if (-not (Test-Path -Path $CompressFontFile)) {
        # Installs the zip with all font variants
        Invoke-WebRequest -Uri $Uri -OutFile $CompressFontFile
        $processCount = $processCount + 1
    }

    if (-not (Test-Path -Path $ResultingFontFolder)) {
        # Unzip the font zip
        Expand-Archive -Path $CompressFontFile -DestinationPath $ResultingFontFolder
        $processCount = $processCount + 1
    }

    Get-ChildItem -Path $FontPathChildItem -Include $Includes -Exclude $Excludes | ForEach-Object {
        if (-not (Test-Path -Path "C:\Windows\Fonts\$($_.Name)")) {
            $SystemFontPath.CopyHere($_.FullName, 0x10)
            Write-Host "'$($_.Name)' installed."
            $processCount = $processCount + 1
        }
    }
}

# Checks if the module was installed before with `Install-Module`, if not, installs it.
function Internal_Dotfiles_PS_CheckAndInstallModule {
    Param(
        [Parameter(Mandatory, HelpMessage = "The module's name.")]
        [string] $ModuleName
     )

    if ($null -eq (Get-Module $ModuleName)) {
        Write-Host "Installing $ModuleName..."
        Install-Module $ModuleName
        Write-Host "--> $ModuleName installed."
        $processcount = $processcount + 1
    }
}

# Installs winget packages
function Internal_Dotfiles_PS_CheckAndInstallWinGetPackage {
    Param(
        [Parameter(Mandatory, HelpMessage = "The winget package's id.")]
        [string] $PackageId
     )

    $searchResult = winget.exe list --id --exact $PackageId
    $matchPackageId = $searchResult | Select-String $PackageId

    # If winget package was not found. Install it
    if ($null -eq $matchPackageId) {
        Write-Host "Installing $PackageId..."
        winget.exe install --id=$PackageId -e
        Write-Host "--> $PackageId installed."
        $processcount = $processcount + 1
    }
}

function Dotfiles_PS_InstallModules {
    $processcount = 0

    # If not running this script on powershell core >= 7.4
    if (-not ($PSVersionTable.PSEdition -eq "Core" -and $PSVersionTable.PSVersion.Major -ge 7 -and $PSVersionTable.PSVersion.Minor -ge 4)) {
        Internal_Dotfiles_PS_CheckAndInstallModule -ModuleName PSReadLine
    }

    Internal_Dotfiles_PS_CheckAndInstallModule -ModuleName PSFzf

    if (Get-Command winget.exe) {
        Internal_Dotfiles_PS_CheckAndInstallWinGetPackage -PackageId "junegunn.fzf"
    } else {
        Write-Warning "!!--> Winget binary couldn't found. I'll omit the winget packages instalation."
        Write-Warning "!!--> Once you get the winget binary came back to run this target."
    }

    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Modules"
}

# Make a symbolic link to the powershell config
function Dotfiles_PS_SetupPSProfile {
    $processCount = 0
    $psConfigPath = Split-Path $PROFILE.CurrentUserCurrentHost

    if (-not (Test-Path -Path $psConfigPath)) {
        Write-Host "'$psConfigPath' directory not found, creating..."
        New-Item -ItemType Directory -Path $psConfigPath
        $processCount = $processCount + 1
    }

    # PROFILE is the path of the powershell config file.
    if (-not (Test-Path -Path $PROFILE -PathType Leaf)) {
        Write-Host "'$PROFILE' not found, making a symlink..."
        New-Item -ItemType SymbolicLink -Path $PROFILE -Value "$PWD\windows\Microsoft.PowerShell_profile.ps1"
        $processCount = $processCount + 1
    }

    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Powershell profile"
}

function Dotfiles_PS_InstallFonts {
    $processCount = 0
    Internal_Dotfiles_PS_FontInstaller -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip" -FontName "jetbrainsmono" -Includes "JetBrainsMonoNerdFont-*.ttf"
    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "JetBrains Mono font"

    $processCount = 0
    Internal_Dotfiles_PS_FontInstaller -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip" -FontName "iosevka" -Includes "IosevkaNerdFont-*.ttf"
    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Iosevka font"

    $processCount = 0
    Internal_Dotfiles_PS_FontInstaller -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip" -FontName "firacode" -Includes "FiraCodeNerdFont-*.ttf"
    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Fira Code font"
}

# This function assumes you're located in dotfiles's root directory
function Dotfiles_PS_SetupAlacrittyConfigFile {
    $processCount = 0

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

    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Alacritty"
}

function Dotfiles_PS_SetupSymlinks {
    $processCount = 0

    if (-not (Test-Path -Path "$env:HOMEPATH\.gitconfig")) {
        New-Item -Path "$env:HOMEPATH\.gitconfig" -ItemType SymbolicLink -Value "$PWD\.gitconfig"
        $processCount = $processCount + 1
    }

    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Symlink"
}

# Used to when `help` target is matched.
function Dotfiles_PS_ShowScriptInfo {
    Write-Host "Usage: .\setup.ps1 -Target <target>"
    Write-Host "Available targets: $availableTargets"
}

if ($hashTableTargets.ContainsKey($Target)) {
    Invoke-Expression -Command $hashTableTargets[$Target]
} else {
    Write-Host "Unrecognized target. Available targets: $availableTargets"
}
