#!/bin/bash

cd / # THIS CD IS IMPORTANT THE FOLLOWING LONG COMMAND IS RUN FROM /

backup_id=$(hostname).$(date +%4Y%m%d-%H%M%S)
echo $backup_id

tar -cvpzf /backup/backup/backup.tar.gz  \
--exclude=/proc/* \
--exclude=/backup \
--exclude=/backup/* \
--exclude=/tmp/* \
--exclude=/mnt/* \
--exclude=/dev/* \
--exclude=/sys/* \
--exclude=/run/* \
--exclude=/media/* \
--exclude=/var/lock/* \
--exclude=/etc/fstab \
--exclude=/var/cache/apt/archives/* \
--exclude=/usr/src/linux-headers* \
--exclude=/var/tmp \
--exclude=/home/*/.cache/chromium \
--exclude=/home/*/.mozilla/firefox/*/Cache \
--exclude=/home/*/.thumbnails \
--exclude=/home/*/.gvfs \
--exclude=/home/*/Downloads \
--exclude=/home/*/.cache \
--exclude=/home/*/thinclient_drives \
--exclude=/lib/modules/*/volatile/.mounted \
--exclude=/home/*/.local/share/Trash /


mv /backup/backup/backup.tar.gz /backup/backup/precious-backup.${backup_id}.tar.gz
