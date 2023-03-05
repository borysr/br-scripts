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

    export dry_run="" #"--dry-run"

    ## 
echo ">>>>>>>>>>>Backup /etc >>>>>>>>>>>>" $(date)

    export backup_dir="/etc"
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}${backup_dir}" "${backup_dir}/" "${mostrecent_dir}${backup_dir}/"
   
echo ">>>>>>>>>>>Backup /home  >>>>>>>>>>>>" $(date)
    export backup_dir="/home"
# --exclude={'*[Tt]rash','google-chrome','Brave*/*','[Dd]iscord','borysr/.cache/*','libreoffice','snap/*','flatpak/*','.cargo/*','.cinnamon','.dotnet','.aspnet', 'repos'} \
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}${backup_dir}" \
        --exclude='snap'  --exclude='flatpak' --exclude='.cache' --exclude='repo*' \
        --exclude='Brave*' --exclude='.cinnamon' --exclude='.var' \
	--exclude="thinclient_drives" \
	"${backup_dir}/" "${mostrecent_dir}${backup_dir}/"

echo ">>>>>>>>>>>Backup /root >>>>>>>>>>>>" $(date)
    export backup_dir="/root"
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}${backup_dir}"  "${backup_dir}/" "${mostrecent_dir}${backup_dir}/"
   
echo ">>>>>>>>>>>Backup /var >>>>>>>>>>>>" $(date)
    export backup_dir="/var"
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}${backup_dir}" \
        --exclude={"backups","cache","tmp", "spool", "docker"} \
	"${backup_dir}/" "${mostrecent_dir}${backup_dir}/"
   
echo ">>>>>>>>>>>Backup /usr/local/bin >>>>>>>>>>>>" $(date)
    export backup_dir="/usr/local/bin"
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}/usr_local_bin" "${backup_dir}/" "${mostrecent_dir}/usr_local_bin/"
   
echo ">>>>>>>>>>>Backup /usr/local/sbin >>>>>>>>>>>>" $(date)
    export backup_dir="/usr/local/sbin"
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}/usr_local_sbin"  "${backup_dir}/" "${mostrecent_dir}/usr_local_sbin/"
   
echo ">>>>>>>>>>>Backup /srv >>>>>>>>>>>>" $(date)
    export backup_dir="/srv"
    sudo rsync -avh --one-file-system --delete --backup $dry_run \
        --backup-dir="${today_dir}${backup_dir}" "${backup_dir}/" "${mostrecent_dir}${backup_dir}/"
   
echo ">>>>>>>>>>>daily to monthly >>>>>>>>>>>>" $(date)
    sudo rsync -avh --ignore-existing $dry_run ${today_dir}/ ${month_dir}/
    echo "<<<<<<<<<<<<<<<<<<<<<<<" $(date)
# ) &>> /home/borysr/Log/root.out

exit 0
