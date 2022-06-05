#!/bin/bash
set -e

sudo apt install -y -qq python3 python3-pip python3-dev python3-setuptools
pip3 install thefuck --user --no-warn-script-location