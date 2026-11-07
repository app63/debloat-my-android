#!/bin/bash

# debloat.sh - Android Phone Debloater
# Usage: ./tools/debloat.sh <device_ip>

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <device_ip>"
    exit 1
fi

DEVICE_IP=$1
ADB="adb -s $DEVICE_IP"

echo "Connecting to $DEVICE_IP..."
$ADB connect $DEVICE_IP

# Verify connection
if ! $ADB shell getprop ro.product.model > /dev/null 2>&1; then
    echo "Error: Could not connect to device at $DEVICE_IP. Make sure USB debugging is enabled."
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
CURRENT_LAUNCHER=$($ADB shell dumpsys window | grep -E 'mCurrentFocus|mFocusedApp' | grep 'package=' | cut -d'=' -f2 | cut -d'/' -f1 | head -n 1)
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
