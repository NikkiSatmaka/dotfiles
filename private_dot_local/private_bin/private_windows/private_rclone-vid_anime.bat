@echo off
@echo Uploading D:\videos\anime to gdrive:entertainment/anime
@rclone.exe copy -Pv "D:\videos\anime" gdrive:entertainment/anime
@pause