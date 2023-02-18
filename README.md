# Victor's dotfiles

## Pre-requeriments
* [Git](https://git-scm.com/)
* [Chocolatey](https://chocolatey.org/) (Only for Windows users)
* [Homebrew](https://brew.sh/) (Only for Unix users)

## Windows setup
### Requeriments
* PowerShell >= 7.3.0

### Plugins
* [PSReadLine](https://github.com/PowerShell/PSReadLine) - Cmdlets for customizing the editing environment, used for autocompletion
* [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
> My themes for [Oh My Posh](https://ohmyposh.dev/) are located in [themes](/windows/themes) folder

## Unix setup
### Requeriments
* nvm: Node version manager.
* C compiler (gcc) (only if you want to make a build of vim): `sudo apt install gcc`
* ncurses-dev, libncurses5-dev, libncursesw5-dev, build-essential, make (only if you want to make a vim build)
```
$ sudo apt-get install libncurses5-dev libncursesw5-dev
$ sudo apt install make
$ sudo apt install build-essential
```

### Plugins
* [Oh my Zsh](https://ohmyz.sh/) - Prompt theme engine for Unix operative systems
