@echo off
@echo Uploading D:\videos\tv_series to gdrive:entertainment/tv_series
@rclone.exe copy -Pv "D:\videos\tv_series" gdrive:entertainment/tv_series
@pause