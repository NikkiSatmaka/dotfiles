#!/usr/bin/env bash
# -*- coding: utf-8 -*-

idx_exported_csv_dir="$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/amibroker/drive_c/data-ab/idx_exported_csv"
echo "Syncing Upload $idx_exported_csv_dir to gdrive_id:investment/04_data/idx_exported_csv"
rclone sync -Pv $idx_exported_csv_dir gdrive_id:investment/04_data/idx_exported_csv
read