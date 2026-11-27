# Repository guidance

## Repository purpose

This is a Bash-only Android debloating skill. The scripts use ADB to uninstall or disable
installed packages, with separate package restoration guidance. There is no application
build, package manager, or runtime framework.

## Commands

### Debloat

```bash
chmod +x tools/debloat.sh
./tools/debloat.sh                 # only when exactly one device is connected
./tools/debloat.sh <device-id-or-ip>
./tools/debloat.sh --trackers-only <device-id-or-ip>
```

USB serials and IP addresses are accepted. An IP argument causes `adb` to connect to that
address first.

### Restore

Use the repository-supported per-package restore command:

```bash
adb shell cmd package install-existing <package_name>
```

`tools/restore.sh` expects a device IP and prints restoration guidance; it does not maintain
a backup or reinstall packages itself.

### Validation

There is no build or lint tool. At minimum, syntax-check both scripts:

```bash
bash -n tools/debloat.sh tools/restore.sh
```

The only automated test is `.github/workflows/test-skill.yml`. It replaces `adb` with a
mock binary and runs `tools/debloat.sh` against that mock. The targeted scenario is the
end-to-end Play Store/launcher protection behavior. Run the workflow through GitHub Actions,
or reproduce it locally by creating a mock `adb` earlier on `PATH` and running:

```bash
chmod +x tools/debloat.sh
./tools/debloat.sh mock_device
```

Before changing removal or package-list logic, run the mock workflow and confirm it prints
both protected-package skips and the detected launcher protection.

## Architecture

- `tools/debloat.sh` is the implementation entry point. It resolves the target, verifies ADB
  shell access, discovers the active launcher from `dumpsys window`, enumerates packages,
  protects Play Store and launcher, then uses
  `pm uninstall -k --user 0` with `pm disable-user --user 0` as fallback.
- `tools/restore.sh` is a thin IP-based wrapper that documents package restoration because
  the debloat process has no package removal manifest.
- `README.md` is the primary user-facing documentation; localized README variants describe
  the same workflow.
- `AGENTS.md` contains the agent-specific safety and operational rules. Treat that file as
  the source of truth for automation behavior.

## Safety and conventions

- Never remove `com.android.vending` (Google Play Store).
- Never remove `com.google.android.gms` (Google Play Services); tracker-only mode protects it
  explicitly and the existing broad mode protects it too.
- Never remove the dynamically detected current launcher package; the launcher is a
  device-specific package discovered from `dumpsys window`.
- Do not replace the protected-package list with a broad or blacklist-only package list.
- Preserve the `pm uninstall -k --user 0` removal strategy. It keeps app data and allows
  `cmd package install-existing` restoration.
- When uninstall is refused, preserve the existing fallback to
  `pm disable-user --user 0`.
- Put new ADB utilities in `tools/` and make executable scripts executable.
- Use package names as exact, plain strings in Bash; do not infer package identity from app
  labels or package paths.
- Validate launcher detection against `dumpsys window` output when changing that logic,
  because a wrong match can make the device unusable.
