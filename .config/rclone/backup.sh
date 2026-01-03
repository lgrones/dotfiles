#!/bin/bash

source $HOME/.config/rclone/credentials.env

rclone sync /mnt/SSD/ Gdrive:backup \
    --log-file=/tmp/rclone-backup.log \
    --filter "+ Drawing/**" \
    --filter "+ Music/**" \
    --filter "+ Videos/**" \
    --filter "+ Documents/**" \
    --filter "+ Images/**" \
    --filter "+ 3D Printing/**" \
    --filter "- *"
