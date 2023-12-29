#!/bin/bash

# install packages
sudo apt update
sudo apt install -y gcc python3-pip python3.10-venv
python3 -m pip install --user pipx
sudo mv $HOME/.local/bin/* /usr/local/bin
