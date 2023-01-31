#!/bin/sh
alias kssh='kitty +kitten ssh '
export old_ip="rack03"
export old_user=""
export old_login=${old_user}${old_ip}
export old_keys_dir="pre-keys-${old_ip}"

export new_ip="rack03"
export new_user=""
export new_login=${new_ip}
export new_keys_dir="pre-keys-${new_ip}"
export vol_name=pre-rack03
export new_node=pre-rack03

scp -r ~/Documents/nodes/keys/${old_keys_dir} ${new_login}:${new_keys_dir}

kssh ${new_login} "docker run -dt --rm -v ${vol_name}:/app/node --name presearch-restore presearch/node ; docker cp ${new_keys_dir}/. presearch-restore:/app/node/.keys/ ; docker stop presearch-restore"

kssh ${new_login} ls -la

kssh ${old_login} docker ps
kssh ${old_login} docker stop presearch-node presearch-auto-updater

# kssh ${old_login} poweroff

kssh ${new_login} "docker stop ${new_node}; docker rm ${new_node}; docker stop pre-auto-updater; docker rm pre-auto-updater; docker run -d --name pre-auto-updater --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock presearch/auto-updater --cleanup --interval 900 pre-auto-updater ${new_node} iore-rack21 && docker pull presearch/node && docker run -dt --name ${new_node} --restart=unless-stopped -v ${vol_name}:/app/node presearch/node && sleep 10 && docker logs ${new_node}"

# kssh ${old_login}

