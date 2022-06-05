#!/bin/bash
set -e

if ! command -v sudo 1> /dev/null; then
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

manual/install-deps.sh

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Creating .dotfile symlinks..."$(tput sgr0)"

manual/create-symlinks.sh

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring ZSH and oh-my-zsh..."$(tput sgr0)"

manual/install-zsh.sh

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Configuring nvm..."$(tput sgr0)"

manual/install-nvm.sh

echo "$(tput setaf 2)"...done"$(tput sgr0)"
echo "$(tput setaf 3)"Installing thefuck..."$(tput sgr0)"

manual/install-thefuck.sh

echo "$(tput setaf 2)"...done"$(tput sgr0)"

while true; do
  read -rep "Do you want to install Java 8 and 18? [yN] " -i "n" answer
  case $answer in
    [Yy]* )
      echo "$(tput setaf 3)"Installing Java 8 and 18..."$(tput sgr0)"
      manual/install-java.sh
      break
      ;;
    [Nn]* )
      echo "$(tput setaf 3)"Skipping Java install."$(tput sgr0)"
      break
      ;;
    * )
      echo 'Unknown answer.'
      ;;
  esac
done

echo "$(tput setaf 2)"...done. Exit and reopen the terminal to see effects."$(tput sgr0)"
echo "$(tput setaf 2)"You might want to install a powerline patched font, such as the ones provided in the fonts/ folder."$(tput sgr0)"


