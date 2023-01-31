#!/bin/sh -x
alias kssh='kitty +kitten ssh '
export keys_dir="/home/borysr/Documents/nodes/presearch/keys"
export old_ip="oracl02"
export old_user=""
export old_login=${old_user}${old_ip}
export node_id="pre07"

export new_ip="azure04"
export new_user=""
export new_login=${new_ip}

scp -r ${keys_dir}/${node_id} ${new_login}:${node_id}

kssh ${new_login} "docker stop presearch_node; docker rm presearch_node; docker run -dt --rm -v ${node_id}:/app/node --name presearch-restore presearch/node ; docker cp ${node_id}/. presearch-restore:/app/node/.keys/ ; docker stop presearch-restore"

kssh ${new_login} ls -la

kssh ${old_login} docker ps
kssh ${old_login} docker stop presearch-node presearch-auto-updater pre-auto-updater

# kssh ${old_login} poweroff

kssh ${new_login} "docker stop ${node_id}; docker stop pre-auto-updater; docker rm pre-auto-updater; docker run -d --name pre-auto-updater --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock presearch/auto-updater --cleanup --interval 900 pre-auto-updater ${node_id} && docker pull presearch/node && docker run -dt --name ${node_id} --restart=unless-stopped -v ${node_id}:/app/node presearch/node && sleep 10 && docker logs ${node_id}"

# kssh ${old_login}

