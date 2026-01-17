# Cursor Restart Steps

## What To Do

### Step 1: Fully Quit Cursor

1. Press `Cmd+Q` to quit Cursor completely
2. Wait a few seconds
3. Check Cursor is closed (not just the window)

### Step 2: Reopen Cursor

1. Open Cursor app
2. Reopen this project: `/Users/markzeidan/Documents/source/jetson2`

### Step 3: Try Connecting

1. `Cmd+Shift+P` → "Remote-SSH: Connect to Host"
2. Select: `jetson`
3. Should connect automatically (no password since SSH key is working)

## If Still Failing After Restart

### Check SSH Config is Readable

```bash
chmod 600 ~/.ssh/config
ls -la ~/.ssh/config
```

Should show `-rw-------` (only you can read/write)

### Verify Settings

Check Cursor settings file:
```bash
cat ~/Library/Application\ Support/Cursor/User/settings.json
```

Should have `"remote.SSH.showLoginTerminal": true` if you still need password prompt.

But since SSH key works, you shouldn't need password prompt anymore!

## What To Expect

After restart:
- `Cmd+Shift+P` → "Remote-SSH: Connect to Host" → `jetson`
- Should connect automatically
- No password prompt (SSH key handles authentication)
- Takes 2-5 minutes on first connection to install cursor-server

## If Connection Still Fails

Check Cursor's output panel:
- View → Output
- Select "Remote-SSH" from dropdown
- Look for error messages

The error should give us clues about what's failing.
