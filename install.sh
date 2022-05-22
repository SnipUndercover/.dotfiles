#!/bin/bash
set -e

SCRIPT_PATH="${0%/*}"
cd "$SCRIPT_PATH"
SCRIPT_PATH="$PWD"

if ! command -v sudo; then
  echo "$(tput setaf 1)"Could not find sudo. Please install sudo to use this script."$(tput sgr0)"
  exit 2
fi

if ! sudo -v; then
  echo "$(tput setaf 1)"You "do" not appear to have sudo privileges."$(tput sgr0)"
  exit 2
fi

echo "$(tput setaf 3)"Updating apt..."$(tput sgr0)"

sudo apt update -qq

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Installing applications..."$(tput sgr0)"

echo "$(tput setaf 6)"- git"$(tput sgr0)"
sudo apt install -y -qq git

echo "$(tput setaf 6)"- curl"$(tput sgr0)"
sudo apt install -y -qq curl

echo "$(tput setaf 6)"- 7z"$(tput sgr0)"
sudo apt install -y -qq p7zip-full

echo "$(tput setaf 6)"- vim"$(tput sgr0)"
sudo apt install -y -qq vim

echo "$(tput setaf 6)"- bat"$(tput sgr0)"
sudo apt install -y -qq bat

echo "$(tput setaf 6)"- exa"$(tput sgr0)"
cd /tmp
curl -Lo exa.zip https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
7z x -oexa exa.zip
cd exa
sudo cp ./bin/* /usr/local/bin
sudo cp ./man/* /usr/share/man/man1
sudo cp ./completions/exa.bash /etc/bash_completion.d
sudo cp ./completions/exa.fish /usr/share/fish/vendor_completions.d
sudo cp ./completions/exa.zsh /usr/local/share/zsh/site-functions
cd ..
rm -rf exa
cd "$SCRIPT_PATH"

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Creating .dotfile symlinks..."$(tput sgr0)"

echo "$(tput setaf 6)" - ~/.gitconfig"$(tput sgr0)"
ln -sf "$SCRIPT_PATH"/.gitconfig ~/.gitconfig

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

sudo apt install -y -qq python3 python3-pip python3-dev python3-setuptools
pip3 install thefuck --user --no-warn-script-location

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
