#!/bin/bash

cd / # THIS CD IS IMPORTANT THE FOLLOWING LONG COMMAND IS RUN FROM /

backup_id=$(hostname).$(date +%4Y%m%d-%H%M%S)
echo $backup_id

tar -cvpzf backup.home.tar.gz  \
--exclude=/home/*/.gvfs --exclude=/home/*/.cache --exclude=/home/*/Downloads \
--exclude=/home/*/thinclient_drives \
--exclude=/home/*/.local/share/Trash /home/

mv backup.home.tar.gz backup.home.${backup_id}.tar.gz

tar -cvpzf backup.etc.tar.gz /etc/

mv backup.etc.tar.gz backup.etc.${backup_id}.tar.gz
