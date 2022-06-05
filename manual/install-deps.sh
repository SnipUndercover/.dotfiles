#!/bin/bash
set -e

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
pushd /tmp
curl -Lo exa.zip https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
7z x -oexa exa.zip
cd exa
sudo cp ./bin/* /usr/local/bin
sudo cp ./man/* /usr/share/man/man1
sudo mkdir -p /etc/bash_completion.d
sudo cp ./completions/exa.bash /etc/bash_completion.d
sudo mkdir -p /usr/share/fish/vendor_completions.d
sudo cp ./completions/exa.fish /usr/share/fish/vendor_completions.d
sudo mkdir -p /usr/local/share/zsh/site-functions
sudo cp ./completions/exa.zsh /usr/local/share/zsh/site-functions
cd ..
rm -rf exa exa.zip
popd