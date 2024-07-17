@echo off
@echo Syncing Download gdrive:entertainment/books/calibre_library to D:\calibre_library
@rclone.exe sync -Pv gdrive:entertainment/books/calibre_library "D:\calibre_library"
@pause