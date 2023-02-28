# Victor's dotfiles

## Windows setup

### Requeriments
* [Git](https://git-scm.com/)
* [Chocolatey](https://chocolatey.org/) (Only for Windows users)
* PowerShell >= 7.3.0

### Plugins
* [PSReadLine](https://github.com/PowerShell/PSReadLine) - Cmdlets for customizing the editing environment, used for autocompletion
* [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine

**Note:** My themes for [Oh My Posh](https://ohmyposh.dev/) are located in [themes](/windows/themes) folder

## Unix setup
Dotfiles (un)installation are managed by scripts located un [scripts](/scripts/) folder, you need to convert the script file you want to execute as Bash Script Executable file.

> **Installation**
* Linux OS: [INSTALL.sh](/scripts/INSTALL.sh)
* Termux: [TERMUX.sh](/scripts/TERMUX.sh)

> **Uninstallation**
* Linux OS: [UNINSTALL.sh](/scripts/UNINSTALL.sh)
* Termux: [TERMUX-UNINSTALL.sh](/scripts/TERMUX-UNINSTALL.sh)

## Installation

> **Linux OS**
```
$ chmod u+x ./scripts/INSTALL.sh
```

> **Termux**
```
$ chmod u+x ./scripts/TERMUX.sh
```

## Uninstallation

> **Linux OS**
```
$ chmod u+x ./scripts/UNINSTALL.sh
```

> **Termux**
```
$ chmod u+x ./scripts/TERMUX-UNINSTALL.sh
```

**Note:**
* If you want to convert to Bash Script Executable file all scripts located in [scripts](/scripts/) folder, type the following command:

```
$ chmod u+x ./scripts/*.sh
```

### Plugins
* [Oh my Zsh](https://ohmyz.sh/) / [Oh my Bash](https://ohmybash.nntoan.com/) - Prompt theme engine for Unix operative systems
