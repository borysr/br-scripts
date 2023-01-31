#!/bin/bash -e
# This is run as root at the end of the day

# (   
echo ">>>>>>>>>>>>>>>>>>>>>>>" $(date)
    export today=$(date +%Y-%m-%d)
    export month=$(date +%Y-%m)
    # 
    export backup_base_dir=/mnt/synology/NetBackup/precious
    export today_dir="${backup_base_dir}/${today}"
    export month_dir="${backup_base_dir}/${month}"

mkdir -p $today_dir
mkdir -p $month_dir

export dry_run="" ## "--dry-run"
   
echo ">>>>>>>>>>>Backup /  >>>>>>>>>>>>" $(date)
    export backup_dir=""
    sudo rsync -avhz ssh -p 1022 --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}" \
	--exclude-from='./exclude-list-home.txt' \
	"/" borysr@192.168.9.200:"/volume1/NetBackup/precious/mostrecent/"
exit 0
