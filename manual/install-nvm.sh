#!/bin/bash
set -e

pushd ~
git clone https://github.com/nvm-sh/nvm.git .nvm
cd .nvm
git checkout "$(git tag -l | sort -Vr | head -1)"
# shellcheck disable=SC1091
. ./nvm.sh
nvm install node
npm install -g typescript
popd