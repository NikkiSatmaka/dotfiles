@echo off
@echo Uploading D:\books to gdrive:entertainment/books
@rclone.exe copy -Pv "D:\books" gdrive:entertainment/books
@pause