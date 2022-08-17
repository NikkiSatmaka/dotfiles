#!/usr/bin/env sh

echo "Uploading /mnt/data/nikki/torrent-seed to gdrive_id:torrent-seed"
rclone copy -Pv /mnt/data/nikki/torrent-seed gdrive_id:torrent-seed
read