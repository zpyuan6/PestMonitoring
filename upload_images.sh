#!/bin/bash

if [ $# -eq 0 ]; then
        echo "Can not find scan path"
        exit 1
fi

SCAN_PATH="$1"
INTERVAL=$(echo "scale=0; $2 / 1000" | bc)
FAIL_FOLDER="/home/zhipeng/Desktop/FAILED_UPLOAD"

if [ ! -d "$FAIL_FOLDER" ]; then
    mkdir -p "$FAIL_FOLDER"
fi

echo "Scan path: $SCAN_PATH"
echo "Interval $INTERVAL"

OSS_PATH="oss://fcimcshk/DataCollection"

while true; do
        for file in "$SCAN_PATH"/*.JPG; do
                if [ -f "$file" ]; then
                        TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
                        FILENAME="Image_${TIMESTAMP}.JPG"

                        echo "$TIMESTAMP: Find file. Try to upload $file to $OSS_PATH/$FILENAME ==============="

                        ossutil cp "$file" "$OSS_PATH/$FILENAME"

                        if [ $? -eq 0 ]; then
                                echo "Upload file success.Remove local file."
                                rm "$file"
                        else
                                echo "Upload file fail. Move file to failed folder in local"
                                mv "$file" "$FAIL_FOLDER/$FILENAME"
                        fi
                fi
        done
        echo "Start sleep $INTERVAL seconds"
        sleep $INTERVAL
done