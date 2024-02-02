# Awus036ach_Driver_Setup
This script simplifies the installation of the AWUS036ach wireless adapter driver on openSUSE Tumbleweed, Kali Linux, Ubuntu. It automates the process, making it easier for users to set up their wireless adapters.

# AWUS036ach Driver Installation Script
*Created by:* 7PiNz

**Script Name:** `awus036ach_driver_install.sh`


## Introduction

This script is designed to guide you through the process of installing the driver for your AWUS036ach wireless adapter on openSUSE Tumbleweed, Kali Linux, Ubuntu. It automates the installation steps, making it easier for users to set up their wireless adapter.

## Prerequisites

Before running the script, please ensure you meet the following prerequisites:

- You have administrative privileges or can use `sudo` to run the script.
- Your system is connected to the internet.

## Usage

Follow these steps to install the AWUS036ach driver using this script:

1. **Download the Script:**

   Download the `awus036ach_driver_install.sh` script to your computer.

2. **Make the Script Executable:**

   Open a terminal and navigate to the directory where you saved the script. Make it executable by running the following command:

   ```bash
   chmod +x awus036ach_driver_install.sh
   ```

3. **Run the Script:**

   Execute the script with administrative privileges using `sudo`:

   ```bash
   sudo ./awus036ach_driver_install.sh
   ```

4. **Follow the Script Steps:**

   The script will provide a series of steps and prompts. Follow these steps:

   - It will update your system's package repositories and upgrade the system.
   - It will install the required packages such as `dkms`, `git`, `build-essential`, and `linux-headers`.
   - The script will clone or update the `rtl8812au` driver repository from GitHub.
   - It will build and install the driver.
   - The script will load the driver module into the kernel.
   - It will check if the driver was loaded successfully.

5. **Restart Your Computer:**

   If the script indicates a successful installation, it's recommended to restart your computer for the changes to take effect.

## Troubleshooting

- If you encounter any errors during the installation, check the log file at `/var/log/rtl8812au_install.log` for more information on what went wrong.
- Ensure that your system meets the prerequisites mentioned earlier.
- If you face any issues, please seek assistance from online forums or communities related to Linux.

## Disclaimer

This script is provided as-is, and the author takes no responsibility for any damage or issues that may arise from its usage. Use it at your own risk, and ensure you have a backup of your important data.
