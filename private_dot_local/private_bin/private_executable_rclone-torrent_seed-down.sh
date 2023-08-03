#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Downloading gdrive_rfid:torrent-seed to $HOME/data/torrent-seed"
rclone copy -Pv gdrive_rfid:torrent-seed $HOME/data/torrent-seed
read
