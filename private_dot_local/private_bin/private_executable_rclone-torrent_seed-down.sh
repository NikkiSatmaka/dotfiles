#!/usr/bin/env sh

echo "Downloading gdrive_id:torrent-seed to /mnt/data/nikki/torrent-seed"
rclone copy -Pv gdrive_id:torrent-seed /mnt/data/nikki/torrent-seed
read