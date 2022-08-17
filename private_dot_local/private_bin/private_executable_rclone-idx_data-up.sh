#!/usr/bin/env sh

idx_exported_csv_dir="/home/nikki/.var/app/com.usebottles.bottles/data/bottles/bottles/amibroker/drive_c/data-ab/idx_exported_csv"
echo "Syncing Upload $idx_exported_csv_dir to gdrive_ns:investment/04_data/idx_exported_csv"
rclone sync -Pv $idx_exported_csv_dir gdrive_ns:investment/04_data/idx_exported_csv
read