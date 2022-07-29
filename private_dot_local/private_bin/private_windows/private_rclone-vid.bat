@echo off
@echo Uploading D:\videos to gdrive:entertainment
@rclone.exe copy -Pv "D:\videos" gdrive:entertainment
@pause