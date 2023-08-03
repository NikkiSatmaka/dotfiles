#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Uploading $HOME/data/torrent-seed to gdrive_rfid:torrent-seed"
rclone copy -Pv $HOME/data/torrent-seed gdrive_rfid:torrent-seed
read
