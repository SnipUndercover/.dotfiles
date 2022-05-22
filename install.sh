#!/bin/bash

function fail() {
  echo "$(tput setaf 1)Aborting.$(tput sgr0)"
  exit "$1"
}

SCRIPT_PATH="${0%/*}"
cd "$SCRIPT_PATH" || exit
SCRIPT_PATH="$PWD"
if ! sudo apt install -y curl; then
  echo 'Curl needs to be installed for this script to work.'
  fail 1
fi
if ! sudo apt install -y git; then
  echo 'Git needs to be installed for this script to work.'
  fail 1
fi

echo "$(tput setaf 3)"Creating .dotfile symlinks..."$(tput sgr0)"

ln -s "$SCRIPT_PATH"/.gitconfig ~

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Installing Java 8 and 18..."$(tput sgr0)"

if ! sudo apt install -y \
  openjdk-18-jdk-headless \
  openjdk-18-jre-headless \
  openjdk-8-jdk-headless \
  openjdk-8-jre-headless; then
  echo "$(tput setaf 3)"An error occurred while installing Java 18 and 8, continuing."$(tput sgr0)"
fi

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Installing bat and exa..."$(tput sgr0)"

if ! sudo apt install -y bat; then
  echo "$(tput setaf 3)"An error occurred while installing bat, continuing."$(tput sgr0)"
fi
if ! sudo apt install -y exa; then
  echo "$(tput setaf 3)"An error occurred while installing exa, continuing."$(tput sgr0)"
fi

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring ZSH and oh-my-zsh..."$(tput sgr0)"

if ! sudo apt install zsh -y; then
  echo "$(tput setaf 3)"An error occurred while installing zsh. Cannot proceed further."$(tput sgr0)"
  fail 1;
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
ln -s "$SCRIPT_PATH"/.zshrc ~
chsh -s "$(which zsh)"

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring nvm..."$(tput sgr0)"

cd ~ || fail 1
git clone https://github.com/nvm-sh/nvm.git
cd nvm || fail 1
git checkout "$(git tag -l | sort -Vr | head -1)"
# shellcheck disable=SC1091
. ./nvm.sh
nvm install node
npm install -g typescript
cd "$SCRIPT_PATH" || fail 1

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring thefuck..."$(tput sgr0)"

if ! sudo apt install -y python3 python3-pip python3-dev python3-setuptools; then 
  echo "$(tput setaf 3)"An error occurred while installing python. Cannot proceed further."$(tput sgr0)"
  fail 1;
fi
if ! pip3 install thefuck --user; then
  echo "$(tput setaf 3)"An error occurred while installing thefuck, continuing."$(tput sgr0)"
fi

echo "$(tput setaf 2)"...done. Exit and reopen the terminal to see effects."$(tput sgr0)"
