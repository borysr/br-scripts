#!/bin/bash -e
# This is run as root at the end of the day

(   echo ">>>>>>>>>>>>>>>>>>>>>>>" $(date)
    today=$(date +%Y-%m-%d)
    month=$(date +%Y-%m)
    # USB backups
    cd /media/ray/Backup-Ray
    rsync --archive --one-file-system --delete --backup \
        --backup-dir="../../$today/etc" "/etc/" "mostrecent/etc/"
    rsync --archive --one-file-system --delete --backup \
        --backup-dir="../../$today/home" \
        --exclude=".config/google-chrome/" \
        --exclude=".local/share/zeitgeist/" \
        --exclude=".cache/" --exclude="Trash/" --exclude="Downloads/" \
        "/home/" "mostrecent/home/"
    rsync --archive --ignore-existing $today/ $month/
    echo "<<<<<<<<<<<<<<<<<<<<<<<" $(date)
) &>>/home/ray/Log/root.out

exit 0
