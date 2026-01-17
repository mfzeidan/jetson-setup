# Fix: Network Discovery / Privacy Settings

## The Problem

If you disabled "letting this Mac find other devices on the network," this can block SSH connections even though terminal SSH might work in some contexts.

## Check Network Discovery Settings

### Step 1: Check Network Privacy Settings

1. **System Settings** → **Privacy & Security**
2. Look for **Local Network** or **Network** section
3. Find **Cursor** in the list
4. **Enable** network access for Cursor

### Step 2: Check AirDrop / Network Discovery

1. **System Settings** → **General** → **AirDrop & Handoff**
2. Or **System Settings** → **Network** → **Wi-Fi** → **Advanced**
3. Look for settings like:
   - "Limit IP address tracking"
   - "Network discovery"
   - "Find devices on network"

### Step 3: Check Network Location Settings

1. **System Settings** → **Network**
2. Click **Details** next to your Wi-Fi connection
3. Go to **TCP/IP** or **Advanced**
4. Make sure settings allow network access

## Quick Fix: Re-enable Network Discovery

### Method 1: Via System Settings

1. **System Settings** → **Privacy & Security** → **Local Network**
2. Find **Cursor** and enable it
3. If Cursor isn't listed, check **Full Disk Access** or **Network** permissions

### Method 2: Check What Apps Need Network Access

1. **System Settings** → **Privacy & Security**
2. Check these sections:
   - **Local Network**: Enable for Cursor
   - **Full Disk Access**: Sometimes needed for SSH config
   - **Network**: Should be enabled

### Method 3: Network Profile Reset

If settings are confusing, you can reset network location:

1. **System Settings** → **Network**
2. Click the **Location** dropdown (top)
3. Try selecting a different location or "Automatic"

## Test After Changes

After enabling network discovery:

1. **Reload Cursor window**: `Cmd+Shift+P` → "Developer: Reload Window"
2. Try connecting: `Cmd+Shift+P` → "Remote-SSH: Connect to Host" → `jetson`
3. Should connect now!

## Why This Matters

Even if terminal SSH works, Cursor might need explicit permission to access the local network. Terminal uses system SSH with broader permissions, while Cursor runs as an app with restricted network access.

## Quick Check

Run this to see what network interfaces are active:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1
```

This shows your active network interfaces. If Cursor can't access these, that's the issue.
