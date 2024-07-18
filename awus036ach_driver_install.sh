#!/bin/bash

# AWUS036ach Driver Installation Script
LOG_FILE="/var/log/rtl8812au_install.log"

# Print ASCII Art
cat << "EOF"

    |     '||'      '||''''|     |    
   |||     ||        ||  .      |||   
  |  ||    ||        ||''|     |  ||  
 .''''|.   ||        ||       .''''|. 
.|.  .||. .||.....| .||.     .|.  .||.

EOF

echo "---------------------------------------------------------------"
echo "Welcome to the AWUS036ach Driver Installation!"
echo "This script will guide you through installing the driver for your wireless adapter."
echo "All progress will be logged to: $LOG_FILE"
echo "---------------------------------------------------------------"
sleep 2

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo "ERROR: This script must be run as root. Please use sudo."
    exit 1
fi

# Function to update package repositories and upgrade the system
update_system() {
    echo "STEP 1: Updating package repositories and upgrading the system..."
    echo "This ensures your system has the latest updates and dependencies."
    if command -v apt-get &> /dev/null; then
        apt-get update && apt-get upgrade -y | tee -a $LOG_FILE
    elif command -v zypper &> /dev/null; then
        zypper refresh && zypper update -y | tee -a $LOG_FILE
    else
        echo "Unsupported package manager. Please update your system manually."
        exit 1
    fi
    echo "System update and upgrade complete."
    sleep 2
}

# Function to install required packages
install_packages() {
    echo "STEP 2: Installing required packages for the driver installation..."
    echo "This includes dkms, git, build-essential, and linux headers."
    if command -v apt-get &> /dev/null; then
        apt-get install -y dkms git build-essential linux-headers-$(uname -r) | tee -a $LOG_FILE
    elif command -v zypper &> /dev/null; then
        zypper install -y dkms git make gcc kernel-default-devel | tee -a $LOG_FILE
    else
        echo "Unsupported package manager. Please install the required packages manually."
        exit 1
    fi
    echo "Required packages installed."
    sleep 2
}

# Function to clone or update the rtl8812au repository
clone_or_update_repo() {
    rtl8812au_dir="/usr/src/rtl8812au"
    echo "STEP 3: Cloning the rtl8812au driver repository from GitHub..."
    if [ -d "$rtl8812au_dir" ]; then
        echo "Repository already exists. Updating the existing repository..."
        cd "$rtl8812au_dir" && git pull | tee -a $LOG_FILE
    else
        git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git "$rtl8812au_dir" | tee -a $LOG_FILE
    fi
    echo "Repository cloned/updated."
    sleep 2
}

# Function to build and install the driver
build_and_install_driver() {
    cd "$rtl8812au_dir"
    echo "STEP 4: Building and installing the driver. This may take a few minutes..."
    if make | tee -a $LOG_FILE; then
        if make install | tee -a $LOG_FILE; then
            echo "Driver build and installation process complete."
        else
            echo "ERROR: Driver installation failed. Please check the log file: $LOG_FILE"
            exit 1
        fi
    else
        echo "ERROR: Driver build failed. Please check the log file: $LOG_FILE"
        exit 1
    fi
    sleep 2
}

# Function to load the driver module
load_driver_module() {
    echo "STEP 5: Loading the driver module into the kernel."
    modprobe 88XXau | tee -a $LOG_FILE

    # Check if the driver was loaded successfully
    if lsmod | grep 88XXau > /dev/null; then
        echo "SUCCESS: Driver installation successful!"
        echo "Please restart your computer to ensure the driver functions correctly."
    else
        echo "ERROR: Driver installation failed. Please check the log file: $LOG_FILE"
    fi
}

# Main script execution
update_system
install_packages
clone_or_update_repo
build_and_install_driver
load_driver_module

echo "---------------------------------------------------------------"
echo "Script execution completed. Thank you for using this installer."
echo "Created by: 7PiNz"
echo "---------------------------------------------------------------"

exit 0


