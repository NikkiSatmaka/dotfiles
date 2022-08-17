#!/usr/bin/env sh

echo "Syncing Upload /mnt/data/nikki/calibre_library to gdrive_id:entertainment/books/calibre_library"
rclone sync -Pv /mnt/data/nikki/calibre_library gdrive_id:entertainment/books/calibre_library
read