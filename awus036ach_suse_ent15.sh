#!/bin/bash

# Install AWUS036ach Driver Installation Script for openSUSE Linux Enterprise 15 (SLE 15)

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
echo "Welcome to the InstallAWUS036ach Driver Installation!"
echo "This script will guide you through installing the driver for your wireless adapter."
echo "All progress will be logged to: $LOG_FILE"
echo "---------------------------------------------------------------"
sleep 2

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo "ERROR: This script must be run as root. Please use sudo."
    exit 1
fi

# Update package repositories and upgrade system using zypper
echo "STEP 1: Updating package repositories and upgrading the system..."
echo "This ensures your system has the latest updates and dependencies."
zypper refresh && zypper up -y | tee -a $LOG_FILE
echo "System update and upgrade complete."
sleep 2

# Install required packages
echo "STEP 2: Installing required packages for the driver installation..."
echo "This includes dkms, git, make, gcc, and kernel-devel."
zypper install -y dkms git-core make gcc kernel-devel | tee -a $LOG_FILE
echo "Required packages installed."
sleep 2

# Clone the rtl8812au repository
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

# Change directory to the cloned repository
cd "$rtl8812au_dir"

# Build and install the driver
echo "STEP 4: Building and installing the driver. This may take a few minutes..."
make && make install | tee -a $LOG_FILE
echo "Driver build and installation process complete."
sleep 2

# Load the module
echo "STEP 5: Loading the driver module into the kernel."
modprobe 88XXau | tee -a $LOG_FILE

# Check if the driver was loaded successfully
if lsmod | grep 88XXau > /dev/null; then
    echo "SUCCESS: Driver installation successful!"
    echo "Please restart your computer to ensure the driver functions correctly."
else
    echo "ERROR: Driver installation failed. Please check the log file: $LOG_FILE"
fi

echo "---------------------------------------------------------------"
echo "Script execution completed. Thank you for using this installer."
echo "Created by: 7PiNz"
echo "---------------------------------------------------------------"

exit 0
