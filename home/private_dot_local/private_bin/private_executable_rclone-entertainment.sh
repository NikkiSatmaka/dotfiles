#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Uploading $HOME/data/entertainment to gdrive_rfid:entertainment"
transfer_status=0
rclone copy -Pv "$HOME/data/entertainment" gdrive_rfid:entertainment || transfer_status=$?
if [ -t 0 ]; then
  read -r -p "Press Enter to close..." || :
fi
exit "$transfer_status"
