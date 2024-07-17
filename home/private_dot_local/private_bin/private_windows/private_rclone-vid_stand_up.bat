@echo off
@echo Uploading D:\videos\stand_up to gdrive:entertainment/stand_up
@rclone.exe copy -Pv "D:\videos\stand_up" gdrive:entertainment/stand_up
@pause