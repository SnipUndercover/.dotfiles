#!/bin/bash
set -e
sudo apt install -y -qq zsh
echo "$(tput setaf 3)"Your default shell is about to be changed into "$(which zsh)"."$(tput sgr0)"
echo "$(tput setaf 3)"You will be prompted for your password to confirm."$(tput sgr0)"
chsh -s "$(which zsh)"
ln -sf "$SCRIPT_PATH"/.zshrc ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc