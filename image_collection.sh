#!/bin/bash

SAVE_DIR="/home/zhipeng/Desktop/Captured_Images"
LOG_FILE="/home/zhipeng/Desktop/upload_log.txt"

if [ $# -eq 0 ]; then
        echo "Please input Interval time with milliseconds as unit, such as 3600000 for 1 hour, 60000 for 1 minute."
        exit 1
fi

if [ ! -d "$SAVE_DIR" ]; then
    mkdir -p "$SAVE_DIR"
fi


INTERVAL=$1 # millisecond


#Start Scan SAVE_DIR
nohup ./upload_images.sh $SAVE_DIR $INTERVAL > "$LOG_FILE" 2>&1 &
echo "Start upload_images shell, log is save $LOG_FILE"
libcamera-still --timelapse $INTERVAL -o "$SAVE_DIR/%08d.JPG" --timeout 0 --preview 0,0,1289,640 --width 3840 --height 2160 --autofocus-speed fast --autofocus-on-capture