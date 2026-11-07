# Android Phone Debloater Skill

This repository provides a set of tools to debloat Android phones using ADB (Android Debug Bridge). It removes unnecessary pre-installed apps (bloatware), including Google apps and brand-specific apps, while ensuring the device remains functional.

## 🚀 Features

- **Comprehensive Removal**: Targets all installed packages except for critical system components.
- **Safety First**: 
  - **Protects Google Play Store**: Ensures you can still install and update apps.
  - **Protects Default Launcher**: Dynamically detects and protects the active launcher to prevent bricking the device.
- **Fallback Mechanism**: If a package cannot be fully uninstalled, the tool attempts to disable it.
- **ADB Integration**: Works over USB or Wi-Fi.

## 🛠️ Prerequisites

1. **ADB Installed**: Ensure you have `adb` installed on your computer.
2. **USB Debugging Enabled**: 
   - Go to `Settings` $\rightarrow$ `About Phone` $\rightarrow$ Tap `Build Number` 7 times.
   - Go to `Settings` $\rightarrow$ `System` $\rightarrow$ `Developer Options` $\rightarrow$ Enable `USB Debugging`.
3. **Device Connected**: Connect your phone to your computer via USB or Wi-Fi.

## 📖 Usage

### 1. Debloating your phone

Run the `debloat.sh` script and provide your device's IP address (if using Wi-Fi) or omit it if using USB (you may need to modify the script slightly for USB-only).

```bash
chmod +x tools/debloat.sh
./tools/debloat.sh <your_device_ip>
```

### 2. Restoring apps

If you accidentally removed something important, you can reinstall it using the following ADB command:

```bash
adb shell cmd package install-existing <package_name>
```

## 📂 Project Structure

- `tools/`: Contains the core scripts for debloating and restoration.
  - `debloat.sh`: The main script to remove bloatware.
  - `restore.sh`: Utility script for restoration guidance.

## ⚠️ Disclaimer

**Use this tool at your own risk.** While we take precautions to protect the launcher and Play Store, removing system apps can sometimes lead to unexpected behavior. Always ensure you have a backup of your important data.
