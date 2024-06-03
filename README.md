# Victor's dotfiles

## Notes
- Make sure to run the script on a terminal with administrator permissions.
- Make sure to stay at dotfiles root path when running any script

## Windows setup

### Requeriments
* PowerShell >= 5.1.*

### Installation

> **Installation including all targets**

```shell
$ .\windows\setup.ps1 all
```

> **Installation of a specific target**

```shell
$ .\windows\setup.ps1 <target>
```

> **List of all targets available**

```shell
$ .\windows\setup.ps1 help
```

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

## Todo
- [x] Make a vim installation on windows script
- [x] Make a neovim installation on windows script
- [] Make font installation on unix script
- [] Make a script to automate alacritty shell config depending the operative system
- [] Add env variable from vim binaries directory to user scope in pwsh setup
