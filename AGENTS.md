# Agent Guidance: debloat-my-android

## Core Logic & Constraints
- **Safety First**: Never modify `tools/debloat.sh` to remove protections for the Google Play Store (`com.android.vending`) or the dynamically detected default launcher. Removing these will brick the device or disable app updates.
- **Removal Strategy**: The repository uses `pm uninstall -k --user 0` for removals. This is a non-root method that allows restoration via `cmd package install-existing`.

## Operational Commands
- **Debloat**: `chmod +x tools/debloat.sh && ./tools/debloat.sh [device_id/ip]` (supports USB serials, IPs, or auto-detection if only one device is connected).
- **Restore**: Restoration is currently handled per-package via `adb shell cmd package install-existing <package_name>`.

## Development Workflow
- **New Scripts**: Place all ADB-related utility scripts in the `tools/` directory.
- **Permissions**: Ensure all scripts in `tools/` are executable (`chmod +x`).
- **Verification**: When adding new package lists or removal logic, verify the `dumpsys window` logic still correctly identifies the active launcher to prevent accidental removal.

## Repo Structure
- `tools/`: All executable ADB scripts and logic.
- `README.md`: Primary user documentation and safety warnings.
