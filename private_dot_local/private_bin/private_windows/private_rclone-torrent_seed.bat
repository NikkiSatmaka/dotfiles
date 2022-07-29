@echo off
@echo Uploading D:\torrent-seed to gdrive:torrent-seed
@rclone.exe copy -Pv "D:\torrent-seed" gdrive:torrent-seed
@pause