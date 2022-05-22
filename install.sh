#!/bin/bash
set -e

SCRIPT_PATH="${0%/*}"
cd "$SCRIPT_PATH"
SCRIPT_PATH="$PWD"

echo "$(tput setaf 3)"Installing dependencies..."$(tput sgr0)"

if ! [ -x "$(command -v sudo)" ]; then
  echo 'Could not find sudo. Please install sudo to use this script.'
  exit 2
fi

sudo apt update -qq
sudo apt install -y -qq curl git

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Creating .dotfile symlinks..."$(tput sgr0)"

ln -sf "$SCRIPT_PATH"/.gitconfig ~/.gitconfig

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Installing bat and exa..."$(tput sgr0)"

sudo apt install -y -qq bat exa

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring ZSH and oh-my-zsh..."$(tput sgr0)"

sudo apt install -y -qq zsh
echo "$(tput setaf 3)"Your default shell is about to be changed into "$(which zsh)"."$(tput sgr0)"
echo "$(tput setaf 3)"You will be prompted for your password to confirm."$(tput sgr0)"
chsh -s "$(which zsh)"
ln -sf "$SCRIPT_PATH"/.zshrc ~/.zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring nvm..."$(tput sgr0)"

cd ~
git clone https://github.com/nvm-sh/nvm.git .nvm
cd .nvm
git checkout "$(git tag -l | sort -Vr | head -1)"
# shellcheck disable=SC1091
. ./nvm.sh
nvm install node
npm install -g typescript
cd "$SCRIPT_PATH"

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring thefuck..."$(tput sgr0)"

sudo apt install -y python3 python3-pip python3-dev python3-setuptools
pip3 install thefuck --user

echo "$(tput setaf 2)"...done"$(tput sgr0)"

while true; do
  read -rep "Do you want to install Java 8 and 18? [yN] " -i "n" answer
  case $answer in
    [Yy]* )
      break
      ;;
    [Nn]* )
      echo "$(tput setaf 2)"...done. Exit and reopen the terminal to see effects."$(tput sgr0)"
      exit 0
      ;;
    * )
      echo 'Unknown answer.'
      ;;
  esac
done
echo "$(tput setaf 3)"Installing Java 8 and 18..."$(tput sgr0)"

sudo apt install -qq \
  openjdk-18-jdk-headless \
  openjdk-18-jre-headless \
  openjdk-8-jdk-headless \
  openjdk-8-jre-headless

echo "$(tput setaf 2)"...done. Exit and reopen the terminal to see effects."$(tput sgr0)"
