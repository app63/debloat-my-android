# Android Phone Debloater Skill

This repository provides a specialized skill for AI agents (like OpenCode and Claude) to debloat Android phones and tablets using ADB (Android Debug Bridge). It removes unnecessary pre-installed apps (bloatware), including Google apps and brand-specific apps, while ensuring the device remains functional.

## 🛠️ Installation as a Skill

To use this as a skill, simply provide the following GitHub URL to your AI agent (OpenCode, Claude, etc.):
`https://github.com/app63/debloat-my-android`

The agent will automatically load the `AGENTS.md` and `README.md` instructions to safely debloat your device.

## 🤖 Agent Instructions

When this repository is loaded as a skill, the agent should:
1. **Verify ADB**: Check if `adb` is available in the environment.
2. **Connect Device**: Use `./tools/debloat.sh` with the provided device ID or IP.
3. **Safety Check**: Inform the user that the Google Play Store and the active Launcher are protected and will not be removed.
4. **Execution**: Run the debloat script and report the result.

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

### For AI Agents
The agent can simply run:
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh [device_id/ip]
```

### Manual Usage
If you are running this manually:
```bash
chmod +x tools/debloat.sh
./tools/debloat.sh <your_device_id_or_ip>
```

### Restoring apps
If you accidentally removed something important, you can reinstall it using the following ADB command:
```bash
adb shell cmd package install-existing <package_name>
```

## 📂 Project Structure

- `tools/`: Contains the core scripts for debloating and restoration.
  - `debloat.sh`: The main script to remove bloatware.
  - `restore.sh`: Utility script for restoration guidance.
- `AGENTS.md`: Specific guidance for AI agents operating in this repo.

## ⚠️ Disclaimer

**Use this tool at your own risk.** While we take precautions to protect the launcher and Play Store, removing system apps can sometimes lead to unexpected behavior. Always ensure you have a backup of your important data.
