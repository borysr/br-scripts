#A based on the instructions from this page
#        https://docs.ipfs.tech/how-to/run-ipfs-inside-docker/#set-up
#
# Adapted for DOCUSHIELD beta testing
#
## create directories for ipfs data
#
export BOOTSTRAP="/ip4/13.57.184.41/tcp/4001/p2p/12D3KooWCWvZXbPyqzjfjqzbchqkKDQnfZjwCQhicF6akH6TBmCK"
export HOME_DIR=$(cd ~; pwd)

mkdir ${HOME_DIR}/.ipfs

## create bootstrap script file
cat > 001-test.sh <<EOF
#!/bin/sh
set -ex
ipfs bootstrap rm all
ipfs bootstrap add "$BOOTSTRAP"
EOF

chmod +x 001-test.sh
## swarm.key file should be available here

docker run -d --name ipfs_node -e IPFS_SWARM_KEY="$(cat swarm.key)" -v ${HOME_DIR}/001-test.sh:/container-init.d/001-test.sh -v ${HOME_DIR}/.ipfs:/data/ipfs -p 4001:4001 -p 127.0.0.1:8080:8080 -p 127.0.0.1:5001:5001 ipfs/kubo

## Testing setup using ipfs cli commands in docker:
docker logs ipfs_node
docker exec ipfs_node ipfs swarm peers

