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
* Linux OS: [install.sh](/scripts/install.sh)
* Termux: [TERMUX.sh](/scripts/TERMUX.sh)

> **Uninstallation**
* Linux OS: [uninstall.sh](/scripts/uninstall.sh)
* Termux: [TERMUX-UNINSTALL.sh](/scripts/TERMUX-UNINSTALL.sh)

You need to convert to Bash Script Executable file all scripts located in [scripts](/scripts/) folder, for this, type the following command:

```
$ chmod u+x ./scripts/*.sh
```

### Installation

```
$ ./scripts/install.sh
```

### Uninstallation

```
$ ./scripts/uninstall.sh
```
