@echo off
@echo Syncing Upload C:\Users\nikki\Documents\data-ab\idx_exported_csv to gdrive:investment/04_data/idx_exported_csv
@rclone.exe sync -Pv "C:\Users\nikki\Documents\data-ab\idx_exported_csv" gdrive:investment/04_data/idx_exported_csv
@pause