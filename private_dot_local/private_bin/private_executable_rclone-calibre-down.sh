#!/usr/bin/env sh

echo "Syncing Download gdrive:entertainment/books/calibre_library to /mnt/data/nikki/calibre_library"
rclone sync -Pv gdrive_id:entertainment/books/calibre_library /mnt/data/nikki/calibre_library
read