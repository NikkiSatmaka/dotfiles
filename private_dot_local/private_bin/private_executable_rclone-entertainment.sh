#!/usr/bin/env sh

echo "Uploading /mnt/data/nikki/entertainment to gdrive_id:entertainment"
rclone copy -Pv /mnt/data/nikki/entertainment gdrive_id:entertainment
read