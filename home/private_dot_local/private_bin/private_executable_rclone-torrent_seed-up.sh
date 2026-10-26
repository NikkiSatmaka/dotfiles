#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Uploading $HOME/data/torrent-seed to gdrive_rfid:torrent-seed"
transfer_status=0
rclone copy -Pv "$HOME/data/torrent-seed" gdrive_rfid:torrent-seed || transfer_status=$?
if [ -t 0 ]; then
  read -r -p "Press Enter to close..." || :
fi
exit "$transfer_status"
