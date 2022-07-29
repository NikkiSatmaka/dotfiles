@echo off
@echo Uploading D:\videos\theatre to gdrive:entertainment/theatre
@rclone.exe copy -Pv "D:\videos\theatre" gdrive:entertainment/theatre
@pause