# `~/.dotfiles`
`.dotfiles` are text-based files that live on your home directory and carry your environment configuration.  
By putting them in a repository, you can clone and restore that environment on any system.  
Those are mine.

## Prerequisites
- `sudo` privileges
- `git` (`v1.17.10+`)
- an internet connection

## Installation
```bash
cd ~
git clone https://github.com/SnipUndercover/.dotfiles
cd .dotfiles
./install.sh
```

## Contents
The `install.sh` script will...
1. Perform an `apt update`
1. Install the following:
    - `git`
    - `curl`
    - `p7zip`
    - `vim`
    - [`bat`](https://github.com/sharkdp/bat)
    - [`exa`](https://github.com/ogham/exa)  
      *(The `apt` binary provided is built without `git` support, therefore it must be installed manually for it to work)*
1. Create `~/.dotfile` symlinks for:
    - `~/.gitconfig`
1. Install and configure `ZSH`:
    - Change the default shell to `ZSH`
    - Symlink the [`.zshrc`](#zshrc) config
    - Install [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh)
1. Install and configure [`nvm`](https://github.com/nvm-sh/nvm):
    - Install the latest [`node`](https://github.com/nodejs/node) and [`npm`](https://github.com/npm/cli) build
    - Install [`TypeScript`](https://github.com/microsoft/TypeScript) globally
1. Install `OpenJDK 8` and `18` `JDK` and `JRE`s *(optional)*

This repository also contains compiled  [`Cascadia Code`](https://github.com/microsoft/cascadia-code) *(release&nbsp;[`2111.01`](https://github.com/microsoft/cascadia-code/releases/tag/v2111.01))* fonts.

## `~/.zshrc`
The provided `~/.zshrc` uses the following plugins:
- `aliases`
- `colored-man-pages`
- `common-aliases`
- `debian`
- `extract`
- `git`
- `git-prompt`
- `jsontools`
- `npm`
- `nvm`
- `thefuck`

It also:
- uses the [`agnoster`](https://github.com/agnoster/agnoster-zsh-theme) theme
- sets the default user to `sniping` *(hey, that's me!)*
- overrides aliases to `ls` to use `exa` instead
- creates an `aliases` alias to use the `acs` function exposed by the `aliases` plugin