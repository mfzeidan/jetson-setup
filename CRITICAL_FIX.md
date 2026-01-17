# ⚠️ CRITICAL FIX: macOS Local Network Permission

## The Problem

Cursor Remote-SSH shows **"No route to host"** error even though terminal `ssh jetson` works fine.

## The Solution

**Enable Local Network access for Cursor in macOS System Settings!**

### Steps to Fix

1. **System Settings** → **Privacy & Security** → **Local Network**
2. Find **Cursor** in the list of applications
3. **Enable the toggle switch** (turn it ON - should be blue)
4. **Reload Cursor**: `Cmd+Shift+P` → "Developer: Reload Window"
5. Try connecting again: `Cmd+Shift+P` → "Remote-SSH: Connect to Host" → `jetson`

## Why This Happens

- Terminal SSH uses system SSH with broader permissions
- Cursor runs as an app and needs explicit permission to access the local network
- Disabling "find other devices" or Local Network access blocks Cursor's SSH connections
- Even if firewall is OFF, Local Network permission can still block connections

## What Was Happening

- ✅ Terminal `ssh jetson` worked (system SSH has permissions)
- ❌ Cursor Remote-SSH failed with "No route to host" (app blocked)
- ✅ After enabling Local Network → Cursor connects successfully!

## This Should Be Checked FIRST

If Cursor Remote-SSH fails with "No route to host" but terminal SSH works:
1. **First check**: Local Network permission for Cursor
2. **Then check**: Firewall settings
3. **Then check**: SSH config

This is the most common cause of this issue!

## Settings Location

**macOS System Settings → Privacy & Security → Local Network**

Look for Cursor in the app list and make sure the toggle is ON (blue).
