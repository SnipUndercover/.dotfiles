#!/bin/bash
set -e

SCRIPT_PATH="${0%/*}"
cd "$SCRIPT_PATH/.."
SCRIPT_PATH="$PWD"
echo "$(tput setaf 6)"- \~/.gitconfig"$(tput sgr0)"
ln -sf "$SCRIPT_PATH"/.gitconfig ~/.gitconfig