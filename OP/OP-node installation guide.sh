# Prepare Server
# Min requirements:
# 1 vCPU / 2 GB RAM / 4 GB storage  / OS: We recommend the latest LTS version of Ubuntu or the latest iOS. Nodes should also work on other operating systems, including Windows.

sudo apt update && sudo apt upgrade -y

sudo apt install screen curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar net-tools clang git ncdu pkg-config libssl-dev -y

# Install docker
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo systemctl status docker

# Install docker-compose
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
docker compose version

# Install NodeJS & NPM (20.16.1 min)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Isntall Typesense (API KEY - 'xyz' by default; you may change it as you wish)
export TYPESENSE_API_KEY=xyz
    
mkdir "$(pwd)"/typesense-data

docker run -p 8108:8108 \
            -v"$(pwd)"/typesense-data:/data typesense/typesense:26.0 \
            --data-dir /data \
            --api-key=$TYPESENSE_API_KEY \
            --enable-cors


# Run Ocean node using docker. Private key - your EVM Wallet Private key
git clone https://github.com/oceanprotocol/ocean-node.git && cd ocean-node

# Build image (takes up to 15 minutes, depending on hardware)
docker build -t ocean-node:mybuild .

# Create .env file and enter all required data  (PRIVATE KEY, EVM WALLET PRIVATE KEY, TYPESENSE DB URL, RPC configuration)
./src/helpers/scripts/setupNodeEnv.sh
source .env

# PRIVATE_KEY: (generate a new one or import your own. Key in format 0x...)
# EVM_WALLET_PRIVATE_KEY:   YOUR_EVM_WALLET_ADDRESS
# TYPESENSE_DATABASE: http://localhost:8108/?apiKey=xyz
# Chain_name: click ENTER
# RPC_URL: click ENTER
# Chunk sieze: click ENTER
# Chain_id: click ENTER


# Open .env file and edit lines by removing "export" word from each line. Don't forget to save changes.
sudo nano .env

# Prepare your own .env file. Download .env-example file from the repository and edit it (https://github.com/oceanprotocol/ocean-node/blob/main/.env.example)
# Inside .env file:
# - remove all words "export"
# - remove double quotes from each line
# - Under ##core section remove line RPCS and add following code:
## core
INDEXER_NETWORKS=["23295", "11155420"]
RPCS={"23295":{"rpc":"https://testnet.sapphire.oasis.io","chainId":23295,"network":"oasis_saphire_testnet","chunkSize":100},"11155420":{"rpc":"https://sepolia.optimism.io","chainId":11155420,"network":"optimism-sepolia","chunkSize":100}}
 
# - Under ##p2p section edit following lines:
P2P_ANNOUNCE_ADDRESSES=["/ip4/YOUR_IP/tcp/8000"]

# Save .env file and close.

# Run the node
docker run --env-file .env -e 'getP2pNetworkStats' -p 8000:8000 ocean-node:mybuild

# P2P_ANNOUNCE_ADDRESSES and command getP2pNetworkStats - this  enables your geolocation on the map.
# Wait 5-10 minutes while node is running. Check after your peerID node in the telemetry Ocean Node dashboard (http://your_ip:8000/dashboard/) and Ocean Node Network Registration ( https://nodes.oceanprotocol.com/).
# Ocean Node Dashboard: Import you wallet key in the MM and connect to the dashboard. Check if your Admin rights activated.
