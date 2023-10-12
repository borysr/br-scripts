#!/bin/bash

cd / # THIS CD IS IMPORTANT THE FOLLOWING LONG COMMAND IS RUN FROM /

backup_id=$(hostname).$(date +%4Y%m%d-%H%M%S)
echo $backup_id

tar -cvpzf backup.tar.gz --exclude=/backup.tar.gz --exclude=/backup*gz \
--exclude=/proc --exclude=/tmp --exclude=/mnt --exclude=/dev \
--exclude=/sys --exclude=/run --exclude=/media --exclude=/backup \
--exclude=/var/cache/apt/archives --exclude=/usr/src/linux-headers* \
--exclude=/var/tmp --exclude=/var/spool \
--exclude=/home/*/.gvfs --exclude=/home/*/.cache \
--exclude=/home/*/thinclient_drives \
--exclude=/var/log \
--exclude=/home/*/.local/share/Trash /

mv backup.tar.gz backup.${backup_id}.tar.gz
