# Fix: macOS Permissions Blocking Cursor SSH

## The Problem

Cursor shows "No route to host" even though terminal `ssh jetson` works fine. This is likely macOS blocking Cursor's network access.

## Solution: Check macOS Firewall & Network Permissions

### Step 1: Check Firewall

1. **Open System Settings** (or System Preferences on older macOS)
2. Go to **Privacy & Security** → **Firewall**
3. Check firewall status:
   - **If OFF**: This isn't the issue, skip to Step 2
   - **If ON**: Continue below

4. **If Firewall is ON**:
   - Click **Options** or **Firewall Options**
   - Look for **Cursor** in the list
   - If present: Make sure it's set to **Allow incoming connections**
   - If not present: Add Cursor manually (click "+" and browse to Applications)

### Step 2: Check Network Permissions

1. **System Settings** → **Privacy & Security**
2. Look for **Network** section (or check each permission category)
3. Ensure **Cursor** has network access permissions

### Step 3: Test with Firewall Disabled (Temporary)

To verify firewall is the issue:

1. **Temporarily disable firewall** (for testing only)
2. Try Cursor connection
3. If it works, firewall was blocking it
4. Re-enable firewall and add Cursor exception

**⚠️ Remember to re-enable firewall after testing!**

### Step 4: Alternative - Check App Permissions

1. **System Settings** → **Privacy & Security**
2. Check these sections:
   - **Full Disk Access**: Cursor might need this
   - **Network**: Make sure Cursor is allowed
   - **Files and Folders**: Check SSH config access

## If Permissions Don't Help

The issue might be:
- Cursor's shell context has different PATH or environment
- Network routing issue specific to Cursor's process
- VPN or network proxy interfering

## Quick Test

Try running Cursor from terminal to see if it gets different permissions:

```bash
# Quit Cursor completely
# Then open from terminal:
open -a Cursor
```

Then try connecting again.

## Summary

The most likely fix is **macOS Firewall blocking Cursor**. Check:
1. Firewall settings
2. Add Cursor exception
3. Check network permissions
4. Test connection
