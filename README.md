# Victor's dotfiles

## Windows setup

### Requeriments
* PowerShell >= 7.3.0

**Note**: Make sure to run the script on a terminal with administrator permissions.

#### Installation

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
