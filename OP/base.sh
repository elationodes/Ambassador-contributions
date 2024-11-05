#!/bin/bash

# Print my logo
logo(){
echo -e "\033[0;35m"
echo -e        __      __  _                       __         
echo -e   ___  / /___ _/ /_(_)___  ____  ____  ____/ /__  _____
echo -e  / _ \/ / __ `/ __/ / __ \/ __ \/ __ \/ __  / _ \/ ___/
echo -e /  __/ / /_/ / /_/ / /_/ / / / / /_/ / /_/ /  __(__  ) 
echo -e \___/_/\__,_/\__/_/\____/_/ /_/\____/\__,_/\___/____/  
echo -e
echo 
echo -e "\e[0m"
}

# Headers to announce
header(){
    echo;
    echo;
    echo "${bold}=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=${normal}";
    echo "${bold}-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-${normal}";
    echo -e "\033[92m                $1${normal}";
    echo "${bold}=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=${normal}";
    echo "${bold}-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-${normal}";
    echo;
    sleep 2;
}

# Updating system
system_update() {
  sudo apt update && sudo apt upgrade -y
}

install_requirements() {
  sudo apt install libfuse2 screen curl neofetch iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar net-tools clang git ncdu pkg-config libssl-dev -y
}

# Install Docker and compose plugin
install_docker() {
  # Add Docker's official GPG key:
  snap install docker
  apt install docker-compose -y

}
