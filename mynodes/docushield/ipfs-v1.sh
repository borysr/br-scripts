#!/bin/bash

wget https://dist.ipfs.io/kubo/v0.14.0/kubo_v0.14.0_linux-amd64.tar.gz && 
tar -xvzf kubo_v0.14.0_linux-amd64.tar.gz && 
cd kubo && 
sudo bash install.sh && 
cd .. && 
ipfs init && 
ipfs bootstrap rm all && 
ipfs bootstrap add /ip4/18.144.165.94/tcp/4001/p2p/12D3KooWPXYoBXU5RFYRnhGpnDycW1FZM7hHQehdZjux96nVhQmu && 
echo $'/key/swarm/psk/1.0.0/\n/base16/\n52851b6e315ab5dadfe2fb70a7a22ff5f71b37a1c20b52760ce43a1ecbf3fdf6' > .ipfs/swarm.key && 
ipfs daemon &

# Credit: User -> @n1neb4ll

