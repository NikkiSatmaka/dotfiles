#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Downloading gdrive_rfid:torrent-seed to $HOME/data/torrent-seed"
transfer_status=0
rclone copy -Pv gdrive_rfid:torrent-seed "$HOME/data/torrent-seed" || transfer_status=$?
if [ -t 0 ]; then
  read -r -p "Press Enter to close..." || :
fi
exit "$transfer_status"
