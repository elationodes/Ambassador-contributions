#!/bin/bash

# Print my logo
logo(){
echo -e "\033[36m┌──────────────────────────────────────────────────────────────┐";
echo -e "|                           .----.                             |";
echo -e "|                         ...----....                          |";
echo -e "|         .-=-----. .              ......-====-.               |";
echo -e "|        ---=-==---..                ..---==+++=+=             |";
echo -e "|        .      .  ............. ............    .             |";
echo -e "|                      ..-----==-....      .                   |";
echo -e "|                          --..                                |";
echo -e "|                           .                                  |";
echo -e "|              .        .                                      |";
echo -e "|              .                          ..     .             |";
echo -e "|        .        .            .         . .    ..             |";
echo -e "|        ..                    ..     .  .      ..             |";
echo -e "|        .        -   .             .... -.     ...            |";
echo -e "|        .- .    .-..            .- .... =.     .--            |";
echo -e "|        .#= . .----       .. .  .-.-..=.+..    .--            |";
echo -e "|        .+-...=====.      ..  . .-------+== .. -+-            |";
echo -e "|         ---. =+++=.      .--   --=====-+#+. ..=+.            |";
echo -e "|              -#+##-.-.   -=.- =+==+#@#+@#-                   |";
echo -e "|                .-=-......---. +@+=+##==-.                    |";
echo -e "|                          ==-  =+=-.                          |";
echo -e "|                          .-.                                 |";
echo -e "|                                                              |";
echo -e "|                                                              |";
echo -e "│ ▄▄▄▄    ██▓     ▄▄▄       ▄████▄   ██ ▄█▀ ██▓ ▄████▄  ▓█████ │";
echo -e "│▓█████▄ ░██▒    ▒████▄    ▒██▀ ▀█   ██▄█▒ ▓██░░██▀ ▀█  ▓█   ▀ │";
echo -e "│▒██▒ ▄██▒██░    ▒██  ▀█▄  ▒▓█    ▄ ░███▄░ ▒██░░▓█    ▄ ▒███   │";
echo -e "│▒██░█▀  ▒██░    ░██▄▄▄▄██ ▒▓▓▄ ▄██░░██ █▄ ░██░░▓▓▄ ▄██▒▒▓█  ▄ │";
echo -e "│░▓█  ▀█▓░██████▒ ▓█   ▓██▒▒ ▓███▀ ░░██▒ █▄░██░▒ ▓███▀ ░░▒████▒│";
echo -e "│░▒▓███▀▒░ ▒░▓  ░ ▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒░▓  ░ ░▒ ▒  ░░░ ▒░ ░│";
echo -e "│▒░▒   ░ ░ ░ ▒  ░  ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░ ▒ ░  ░  ▒    ░ ░  ░│";
echo -e "│ ░    ░   ░ ░     ░   ▒   ░        ░ ░░ ░  ▒ ░░           ░   │";
echo -e "│ ░          ░  ░      ░  ░░ ░      ░  ░    ░  ░ ░         ░  ░│";
echo -e "│      ░                   ░                   ░               │";
echo -e "|                                                              |";
echo -e "|           \033[0m🐧 \033[1;34mTelegram: \033[2;32mhttps://t.me/los_pinguin\033[0m  🐧          \033[36m|";
echo -e "└──────────────────────────────────────────────────────────────┘\033[0m";
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
  sudo apt install tmux curl wget
}

# Remoove old docker versions
remoove_old_docker() {
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc;
    do sudo apt-get remove $pkg;
  done
}

# Install Docker and compose plugin
install_docker() {
  # Add Docker's official GPG key:
  snap install docker
  apt install docker-compose -y

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
}
