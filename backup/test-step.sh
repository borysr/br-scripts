#!/bin/bash -e
# This is run as root at the end of the day

# (   
echo ">>>>>>>>>>>>>>>>>>>>>>>" $(date)
    export today=$(date +%Y-%m-%d)
    export month=$(date +%Y-%m)
    # 
    export backup_base_dir=/tmp/rsynctest/precious
    export today_dir="${backup_base_dir}/${today}"
    export month_dir="${backup_base_dir}/${month}"
    export mostrecent_dir="${backup_base_dir}/mostrecent"

mkdir -p $today_dir
mkdir -p $month_dir
mkdir -p $mostrecent_dir

export dry_run="" ## "--dry-run"
   
echo ">>>>>>>>>>>Backup /  >>>>>>>>>>>>" $(date)
    export backup_dir=""
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}${backup_dir}" \
	--exclude-from='./exclude-list-home.txt' \
	"${backup_dir}/" "${mostrecent_dir}${backup_dir}/"
exit 0
