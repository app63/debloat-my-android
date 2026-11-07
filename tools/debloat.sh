#!/bin/bash

# debloat.sh - Android Phone Debloater
# Usage: ./tools/debloat.sh [device_id/ip]
# If no argument is provided, it attempts to use the only connected device.

if [ "$#" -eq 1 ]; then
    TARGET=$1
    ADB="adb -s $TARGET"
elif [ "$#" -eq 0 ]; then
    # Check if exactly one device is connected
    DEVICE_COUNT=$(adb devices | grep -v "List of devices" | grep "device$" | wc -l)
    if [ "$DEVICE_COUNT" -eq 1 ]; then
        echo "No target specified. Using the only connected device..."
        ADB="adb"
    else
        echo "Error: Please specify a device ID or IP address when multiple (or no) devices are connected."
        echo "Usage: $0 [device_id/ip]"
        exit 1
    fi
else
    echo "Usage: $0 [device_id/ip]"
    exit 1
fi

# If we have a target that looks like an IP, try to connect first
if [[ $TARGET =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Connecting to $TARGET..."
    adb connect $TARGET > /dev/null 2>&1
fi

# Verify connection
if ! $ADB shell getprop ro.product.model > /dev/null 2>&1; then
    echo "Error: Could not connect to device. Make sure USB debugging is enabled and the device is authorized."
    exit 1
fi

echo "Connected to $( $ADB shell getprop ro.product.model )"

# List of packages to PROTECT (Never delete/disable)
# 1. Google Play Store
# 2. Default Launcher (to avoid bricking)
PROTECTED_PACKAGES=(
    "com.android.vending" 
)

# We need to dynamically find the current default launcher to protect it
CURRENT_LAUNCHER=$($ADB shell dumpsys window | grep -E 'mCurrentFocus|mFocusedApp' | grep 'package=' | sed 's/.*package=//' | cut -d'/' -f1 | head -n 1)
if [ -n "$CURRENT_LAUNCHER" ]; then
    PROTECTED_PACKAGES+=("$CURRENT_LAUNCHER")
    echo "Protecting current launcher: $CURRENT_LAUNCHER"
fi

echo "Starting debloat process..."

# Get all installed packages
ALL_PACKAGES=$($ADB shell pm list packages -u)

for PKG in $ALL_PACKAGES; do
    PKG=${PKG#package:}
    
    # Skip protected packages
    SKIP=false
    for PROTECTED in "${PROTECTED_PACKAGES[@]}"; do
        if [ "$PKG" == "$PROTECTED" ]; then
            SKIP=true
            break
        fi
    done
    
    if [ "$SKIP" = true ]; then
        echo "Skipping protected package: $PKG"
        continue
    fi

    echo "Removing $PKG..."
    # Attempt to uninstall for user 0
    $ADB shell pm uninstall -k --user 0 "$PKG" > /dev/null 2>&1
    
    # If uninstall failed, try to disable
    if [ $? -ne 0 ]; then
        echo "Could not uninstall $PKG, attempting to disable..."
        $ADB shell pm disable-user --user 0 "$PKG" > /dev/null 2>&1
    fi
done

echo "Debloat complete!"
