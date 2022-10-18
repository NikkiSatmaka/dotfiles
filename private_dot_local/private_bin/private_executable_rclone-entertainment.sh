#!/usr/bin/env bash
# -*- coding: utf-8 -*-

echo "Uploading $HOME/data/entertainment to gdrive_id:entertainment"
rclone copy -Pv $HOME/data/entertainment gdrive_id:entertainment
read