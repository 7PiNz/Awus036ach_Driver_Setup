# AWUS036ach Driver Installation Script

### Created by: 7PiNz

## Introduction

This script is designed to guide you through the process of installing the driver for your AWUS036ach wireless adapter on openSUSE Tumbleweed, Kali Linux, and Ubuntu. It automates the installation steps, making it easier for users to set up their wireless adapter.

## Prerequisites

Before running the script, please ensure you meet the following prerequisites:

- You have administrative privileges or can use sudo to run the script.
- Your system is connected to the internet.

## Usage

Follow these steps to install the AWUS036ach driver using this script:

### Download the Script

Download the `awus036ach_driver_install.sh` script to your computer.

### Make the Script Executable

Open a terminal and navigate to the directory where you saved the script. Make it executable by running the following command:

```bash
chmod +x awus036ach_driver_install.sh
```

### Run the Script

Execute the script with administrative privileges using sudo:

```bash
sudo ./awus036ach_driver_install.sh
```

### Follow the Script Steps

The script will provide a series of steps and prompts. Follow these steps:

1. **System Update and Upgrade**: The script will update your system's package repositories and upgrade the system.
2. **Install Required Packages**: It will install the required packages such as dkms, git, build-essential, and linux-headers.
3. **Clone or Update Driver Repository**: The script will clone or update the rtl8812au driver repository from GitHub.
4. **Build and Install the Driver**: It will build and install the driver.
5. **Load the Driver Module**: The script will load the driver module into the kernel.
6. **Verify Driver Installation**: It will check if the driver was loaded successfully.

### Restart Your Computer

If the script indicates a successful installation, it's recommended to restart your computer for the changes to take effect.

## Manually Changing Modes

To switch the mode of your AWUS036ach wireless adapter, use the following commands:

### Switching to Monitor Mode

Monitor mode is used for packet capturing and is commonly used in network security testing.

#### Using `airmon-ng` (recommended for Kali Linux and similar distros)

```bash
sudo airmon-ng start wlan0
```

This command will put your wireless interface (replace `wlan0` with your actual interface name) into monitor mode. The interface name will typically change to something like `wlan0mon`.

#### Using `iwconfig`

```bash
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 up
```

Replace `wlan0` with your actual interface name.

### Switching to Managed Mode

Managed mode is the default mode for connecting to wireless networks.

#### Using `airmon-ng`

```bash
sudo airmon-ng stop wlan0mon
```

Replace `wlan0mon` with your actual monitor mode interface name. This will stop the monitor mode and switch the interface back to managed mode.

#### Using `iwconfig`

```bash
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode managed
sudo ifconfig wlan0 up
```

Replace `wlan0` with your actual interface name.

## Troubleshooting

If you encounter any errors during the installation, check the log file at `/var/log/rtl8812au_install.log` for more information on what went wrong. Ensure that your system meets the prerequisites mentioned earlier. If you face any issues, please seek assistance from online forums or communities related to Linux.

## Disclaimer

This script is provided as-is, and the author takes no responsibility for any damage or issues that may arise from its usage. Use it at your own risk, and ensure you have a backup of your important data.

