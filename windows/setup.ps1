Param(
    # Target passed as input.
    ##! Modify the help message when a new target is created.
    [Parameter(Mandatory, HelpMessage = 'Targets: all, help, modules, alacritty, symlink, fonts, profile, nvim, vim' )]
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
    'nvim' = "Dotfiles_PS_SetupAndInstallNeovim";
    'vim' = "Dotfiles_PS_SetupAndInstallVim";
}

# Formats the hash table to a comprehensible string
$availableTargets = $hashTableTargets.Keys.ForEach({"`n-> $PSItem"})

# Take care of the edition of powershell you're executing the script to invoke a new terminal with the same type of edition.
function Internal_Dotfiles_PS_InvokeTerminal {
    Param(
            [Parameter(Mandatory, HelpMessage="Put the commands you want to execute. To run more than one command, separate them by (;)")]
            [string] $Command,
            [Parameter(Mandatory=$false, HelpMessage="Specify if the  new terminal instance must the interactive or not.")]
            [bool] $Interactive
         )

    if (-not ($Interactive -eq $true)) {
        $Interactive = $false
    }

    if ($PSVersionTable.PSEdition -eq "Core") {
        if ($Interactive -eq $true) {
            pwsh.exe -Interactive -NoLogo -Command $Command
        } else {
            pwsh.exe -NonInteractive -NoLogo -Command $Command
        }
    } elseif ($PSVersionTable.PSEdition -eq "Desktop") {
        if ($Interactive -eq $true) {
            powershell.exe -Interactive -NoLogo -Command $Command
        } else {
            powershell.exe -NonInteractive -NoLogo -Command $Command
        }
    }
}

# Used to when `all` target is matched.
##! Modify it when a new target function is created.
function Dotfiles_PS_InvokeAllTargets {
    Dotfiles_PS_InstallModules
    Dotfiles_PS_SetupAndInstallVim
    Dotfiles_PS_SetupAndInstallNeovim
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
        Write-Host "--> There were no changes in $ProcessName process. <--" -ForegroundColor Green
    } elseif ($Count -gt 0) {
        Write-Host "--> $ProcessName process successfully executed with $Count changes. <--" -Foregr Green
    } else {
        Write-Host "--> $ProcessName process successfully executed with unknown number of changes. <--" -Foregr Green
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
            Write-Host "'$($_.Name)' installed." -ForegroundColor Green
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

    if ($null -eq (Get-Module $ModuleName -ListAvailable)) {
        Write-Host "Installing $ModuleName..." -ForegroundColor DarkCyan
        Install-Module $ModuleName
        Write-Host "--> $ModuleName installed." -ForegroundColor Green
        $processCount = $processCount + 1
    }
}

# Installs winget packages
function Internal_Dotfiles_PS_CheckAndInstallWinGetPackage {
    Param(
        [Parameter(Mandatory, HelpMessage = "The winget package's id.")]
        [string] $PackageId,
        [Parameter(Mandatory=$false, HelpMessage = "Specify other parameters to execute along winget.")]
        [string] $AdditionalWingetParameters,
        [Parameter(Mandatory=$false, HelpMessage = "Specify if the  new terminal instance must the interactive or not.")]
        [bool] $InteractiveTerminal
     )

    $searchResult = winget.exe list --id $PackageId --exact
    $matchPackageId = $searchResult | Select-String $PackageId

    # If winget package was not found. Install it
    if ($null -eq $matchPackageId) {
        Write-Host "Installing $PackageId..." -ForegroundColor DarkCyan
        Internal_Dotfiles_PS_InvokeTerminal -Command "winget.exe install --id=$PackageId -e $AdditionalWingetParameters" -Interactive $InteractiveTerminal
        Write-Host "--> $PackageId installed." -ForegroundColor Green
        $processCount = $processCount + 1
    }
}

function Dotfiles_PS_InstallModules {
    $processCount = 0

    # If not running this script on powershell core >= 7.4
    if (-not ($PSVersionTable.PSEdition -eq "Core" -and $PSVersionTable.PSVersion.Major -ge 7 -and $PSVersionTable.PSVersion.Minor -ge 4)) {
        Internal_Dotfiles_PS_CheckAndInstallModule -ModuleName PSReadLine
    }

    Internal_Dotfiles_PS_CheckAndInstallModule -ModuleName PSFzf

    if (Get-Command winget.exe) {
        Internal_Dotfiles_PS_CheckAndInstallWinGetPackage -PackageId "junegunn.fzf"
        Internal_Dotfiles_PS_CheckAndInstallWinGetPackage -PackageId "Git.Git"
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
        Write-Host "'$psConfigPath' directory not found, creating..." -ForegroundColor Cyan
        New-Item -ItemType Directory -Path $psConfigPath
        $processCount = $processCount + 1
    }

    # PROFILE is the path of the powershell config file.
    if (-not (Test-Path -Path $PROFILE -PathType Leaf)) {
        Write-Host "'$PROFILE' not found, making a symlink..." -ForegroundColor Cyan
        New-Item -ItemType SymbolicLink -Path $PROFILE -Value "$PWD\windows\Microsoft.PowerShell_profile.ps1"
        $processCount = $processCount + 1
    }

    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Powershell profile"
}

function Dotfiles_PS_SetupAndInstallVim {
    $processCount = 0

    if (Get-Command winget.exe) {
        Internal_Dotfiles_PS_CheckAndInstallWinGetPackage -PackageId "vim.vim" -AdditionalWingetParameters "--interactive" -InteractiveTerminal $true
    } else {
        Write-Warning "!!--> Winget binary couldn't found. I'll omit the winget packages installation."
        Write-Warning "!!--> Once you get the winget binary came back to run this target."
    }

    if (Get-Command git.exe) {
        $vimrcFolderName = "vimfiles"
        $vimrc = "$env:USERPROFILE\$vimrcFolderName"

        # This condition is there because when winget installs vim, automatically creates a vimfiles directory.
        # The intention is to remove that vimrc directory for then clone the correct vimrc directory.
        # The statement also can be treated as a way to update the vimrc to the latest commit.
        if (Test-Path -Path $vimrc) {
            Write-Host "A vimrc directory was found! Removing..." -ForegroundColor Yellow
            Remove-Item -Force -Recurse -Path $vimrc
            $processCount = $processCount + 1
        }

        # This statement always should be executed and this will clone the correct vimrc.
        if (-not (Test-Path -Path $vimrc)) {
            Write-Host "'$vimrc' directory not found, cloning it using git..." -ForegroundColor Cyan
            git.exe clone "https://github.com/barrientosvctor/vimrc.git" $vimrc
            Write-Host "--> Vim dotfiles cloned to '$vimrc'" -ForegroundColor Green
            $processCount = $processCount + 1
        }

	    Write-Host "Installing vim submodules..." -ForegroundColor Cyan
        powershell.exe -NoLogo -NonInteractive -Command "cd $vimrc; .\scripts\actions.ps1 -ActionNumber 1" || pwsh.exe -NoLogo -NonInteractive -Command "cd $vimrc; .\scripts\actions.ps1 -ActionNumber 1"
        $processCount = $processCount + 1
    } else {
        Write-Warning "!!--> Git binary couldn't found. I'll omit the Vim dotfiles installation."
        Write-Warning "!!--> Once you get the Git binary came back to run this target."
    }

    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Vim installation"
}

function Dotfiles_PS_SetupAndInstallNeovim {
    $processCount = 0

    if (Get-Command winget.exe) {
        Internal_Dotfiles_PS_CheckAndInstallWinGetPackage -PackageId "Neovim.Neovim"
    } else {
        Write-Warning "!!--> Winget binary couldn't found. I'll omit the winget packages installation."
        Write-Warning "!!--> Once you get the winget binary came back to run this target."
    }

    if (Get-Command git.exe) {
        $nvimconfigPath = "$env:LOCALAPPDATA\nvim"
	    $nvimdataPath = "$env:LOCALAPPDATA\nvim-data"
        if (-not (Test-Path -Path $nvimconfigPath)) {
            Write-Host "'$nvimconfigPath' directory not found, cloning it using git..." -ForegroundColor Cyan
            git.exe clone "https://github.com/barrientosvctor/nvim.git" "$nvimconfigPath"
            Write-Host "--> Neovim dotfiles cloned to '$nvimconfigPath'" -ForegroundColor Green
            $processCount = $processCount + 1
        }

	    if (Test-Path -Path $nvimdataPath) {
		    Write-Host "I'll remove the Neovim directory '$nvimdataPath' to refresh the Neovim with dotfiles." -Foreground Magenta
		    Remove-Item -Force -Recurse -Path $nvimdataPath
		    $processCount = $processCount + 1

		    Write-Host "Open Neovim after finish the script execution to install plugins." -Foreground Magenta
	    }
    } else {
        Write-Warning "!!--> Git binary couldn't found. I'll omit the Neovim dotfiles installation."
        Write-Warning "!!--> Once you get the Git binary came back to run this target."
    }

    Dotfiles_PS_CountChanges -Count $processCount -ProcessName "Neovim installation"
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
        Write-Host "'$Alacritty_Path' not found. Creating..." -ForegroundColor Cyan
        New-Item -ItemType Directory -Path $Alacritty_Path
        $processCount = $processCount + 1
    }

    if (-Not (Test-Path -Path "$Alacritty_Path\alacritty.toml")) {
        Write-Host "'$Alacritty_File' not found. Creating a symlink..." -ForegroundColor Cyan
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
    Write-Host "Unrecognized target. Available targets: $availableTargets" -ForegroundColor Gray
}
