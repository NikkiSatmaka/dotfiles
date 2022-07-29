@echo off
@echo Syncing Upload D:\calibre_library to gdrive:entertainment/books/calibre_library
@rclone.exe sync -Pv "D:\calibre_library" gdrive:entertainment/books/calibre_library
@pause