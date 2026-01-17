# Cursor Connection Workflow - Final Guide

## The Two Issues We're Solving

1. ✅ **Password prompt** - Fixed by enabling `remote.SSH.showLoginTerminal` in settings
2. ⚠️ **Network connectivity** - Intermittent (Jetson sometimes unreachable)

## The Process

### Step 1: Verify Network is UP (CRITICAL)

**Before trying Cursor, test SSH from terminal:**

```bash
ssh jetson
# Password: password
```

**OR** use the workflow script:
```bash
./connect_cursor_workflow.sh
```

**If SSH works → proceed to Step 2 immediately**  
**If SSH fails ("No route to host") → wait and retry Step 1**

### Step 2: Connect via Cursor (IMMEDIATELY after Step 1)

While terminal SSH is connected (or right after), in Cursor:

1. `Cmd+Shift+P` → "Remote-SSH: Connect to Host"
2. Select: **`jetson`** (not `m@192.168.1.207`)
3. A terminal window should open asking for password
4. Enter: `password`

### Step 3: Wait for Cursor Server Installation

- First connection takes 2-5 minutes
- Cursor downloads and installs `cursor-server` on Jetson
- Don't close the connection during this time

## Why This Works

- `showLoginTerminal` setting shows password prompt in terminal ✅
- SSH config is correct (password auth, no keys) ✅
- Network just needs to be up when Cursor connects ⚠️

## Troubleshooting

### "No route to host" in Cursor
→ Network is down. Test terminal SSH first.

### No password prompt appears
→ Settings were reset. Check `settings.json` has `remote.SSH.showLoginTerminal: true`

### "Connection refused"
→ SSH server not running on Jetson. Check: `sudo systemctl status ssh` (on Jetson)

### Password prompt appears but connection fails
→ Check password is correct: `password`

## Quick Reference

**Test SSH**: `ssh jetson`  
**Connect Cursor**: `Cmd+Shift+P` → "Remote-SSH: Connect to Host" → `jetson`  
**Password**: `password`

**Remember**: Always test terminal SSH first, then immediately connect via Cursor!
