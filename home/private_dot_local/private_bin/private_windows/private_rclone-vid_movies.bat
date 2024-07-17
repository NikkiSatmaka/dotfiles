@echo off
@echo Uploading D:\videos\movies to gdrive:entertainment/movies
@rclone.exe copy -Pv "D:\videos\movies" gdrive:entertainment/movies
@pause