# Fix Cursor SSH Connection Issue

## Problem
Cursor shows "No route to host" but terminal SSH works fine. This is likely because Cursor isn't using your SSH config properly.

## Solution: Use SSH Config Alias

### Try This in Cursor:

1. **In Cursor, press `Cmd+Shift+P`**
2. **Type**: `Remote-SSH: Connect to Host`
3. **IMPORTANT**: Select or type **`jetson`** (not `m@192.168.1.207`)
   - The `jetson` alias uses your SSH config with all proper settings
   - Direct IP might bypass SSH config

### Why This Works:
- Your `~/.ssh/config` has `jetson` configured with:
  - User: `m`
  - HostName: `192.168.1.207`
  - Keepalive settings (`ServerAliveInterval 60`)
  - Password authentication enabled

### Alternative: If `jetson` doesn't appear

If `jetson` doesn't show up in Cursor's list:

1. Try typing `jetson` manually in the connection prompt
2. Or ensure SSH config is readable:
   ```bash
   chmod 600 ~/.ssh/config
   ```

### If Still Failing:

**Option 1**: Test if `jetson` alias works from terminal:
```bash
ssh jetson
# Should connect just like ssh m@192.168.1.207
```

**Option 2**: Check if Cursor is reading SSH config:
- Cursor Remote-SSH should show `jetson` in the host list
- If it doesn't, there might be a config file issue

**Option 3**: Try restarting Cursor after ensuring SSH config is correct

## The Password Issue

You asked if explicit password authentication is the issue. It shouldn't be - password auth is supported. But make sure:

1. SSH config has `PasswordAuthentication yes`
2. Jetson's SSH server allows password auth (already configured)
3. Use the `jetson` alias so Cursor uses the SSH config properly
