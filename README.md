# Pest Monitor
This is a repo for build a pest monitoring device.

## Hardware Design
The pest monitoring devices is builted based on Raspberry Pi. The hardware component and is shown below.

- Computing unit: Raspeberry Pi Zero 2 W. It can theoretically be replaced with other models of Raspberry Pi (such as Raspberry Pi 3B, 4B, and 5) or other microcomputers (support ).
- Camera sensor: Arducam OwlSight - 64MP OV64A40 Autofocus Camera. It can theoretically be replaced by other autofocus camera modules provided by Arducam
- Camera sensor case: Arducam Camera Case (You may do not need to buy it, if the camera already have a case) and Raspberry Pi Mounting Plate for High Quality Camera Basic. This case is important for connecting camera module and holder.
- Computing unit case (Optional): GeeekPi Raspberry Pi Zero 2 W Case (Starter Kit). This case provide a number of important interface converters.
- Camera holder: Universal Multifunction Camera Screw Desk Clamp and Heavy-duty Tripod Swivel Ball Adapter
- Screws and Spacers
- SD card

## Software Setup

The software is running on Raspberry Pi OS (Unix-like operating system based on the Debian Linux distribution). [Link](https://www.raspberrypi.com/software/)

Before you start to use the software, you need to complete following steps.
- Install Raspberry Pi OS 64-bit (Public time 2024-07-04) in SD card. [Useful Link](https://www.raspberrypi.com/software/)
- Setup camera connection. Add following comments after [all] in /boots/config.txt. [Useful Link](https://docs.arducam.com/Raspberry-Pi-Camera/Native-camera/64MP-OV64A40/)
    ```
    dtoverlay=ov64a40,link-frequency=360000000
    camera_auto_detect=0
    ```
- Insert SD card to Raspberry Pi and initial system.
- Install ossutil.
    ```
    sudo -v ; curl https://gosspublic.alicdn.com/ossutil/install.sh | sudo bash
    ```
- Config ossutil for setup oss storage. You can ignore this step, if you do not want to upload captured images to OSS.
- Use following comment to check camera connection and autofocus function. The following comment can demonstrate the camera screen 30 seconds and capture images per 10 seconds. The camera will automatically adjust the focus before capturing images. The ***If not, please solve appeared issues.
    ```
    libcamera-still --timelapse 10000 -o "%08d.JPG" --timeout 30000 --preview 0,0,1289,640 --width 3840 --height 2160 --autofocus-speed fast --autofocus-on-capture
    ```

## How to Use

1. Github clone
2. Assign execute permission for .sh file.
    ```
    sudo chmod +x image_collection.sh
    sudo chmod +x upload_images.sh
    ```
3. Run shell and collect image per 10 minutes.
    ```
    ./image_collection.sh 600000 
    ```

Note. Shell will create two folders and a log file. 
The two folders path is defined as **SAVE_DIR** in image_collection.sh and **FAIL_FOLDER** in upload_images.sh . 
The log file path is defined as **LOG_FILE** in image_collection.sh .
The image_collection.sh need a parameter defining the image capture interval with milliseconds as unit.
The oss uploaded path is defined in upload_images.sh **OSS_PATH**.
