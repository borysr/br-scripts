#!/bin/bash

cd / # THIS CD IS IMPORTANT THE FOLLOWING LONG COMMAND IS RUN FROM /

backup_id=$(hostname).$(date +%4Y%m%d-%H%M%S)
echo $backup_id

tar -cvpzf /mypool/backup.home.tar.gz  \
--exclude=/home/*/.gvfs --exclude=/home/*/.cache --exclude=/home/*/Downloads \
--exclude=/home/*/thinclient_drives \
--exclude=/home/*/.local/share/Trash /home/

mv /mypool/backup.home.tar.gz /mypool/backup.home.${backup_id}.tar.gz

tar -cvpzf /mypool/backup.etc.tar.gz /etc/

mv /mypool/backup.etc.tar.gz /mypool/backup.etc.${backup_id}.tar.gz
