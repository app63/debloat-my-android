#!/bin/bash

# restore.sh - Android Phone Restore
# Usage: ./tools/restore.sh <device_ip>

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <device_ip>"
    exit 1
fi

DEVICE_IP=$1
ADB="adb -s $DEVICE_IP"

echo "Connecting to $DEVICE_IP..."
$ADB connect $DEVICE_IP

echo "Starting restoration process..."
# This is a simplified restore. In a real scenario, we'd need a backup of what was removed.
# Since we used 'pm uninstall -k --user 0', we can reinstall using:
# adb shell cmd package install-existing <package_name>

# This script assumes the user provides a list or we try to re-enable everything.
# Because we don't have a backup file in this simple version, 
# the user should be advised to use a package list if they want specific restoration.
echo "To restore a specific package, use: adb shell cmd package install-existing <package_name>"
echo "Restoration of all packages requires a pre-debloat backup which was not implemented in this basic version."
echo "Restore process finished."
