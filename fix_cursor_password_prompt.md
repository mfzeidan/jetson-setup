# Fix: Cursor Password Prompt Not Appearing

## Problem
Password prompt never appears when connecting via Cursor Remote-SSH, even though:
- SSH config is correct
- Network is working
- Askpass server is running (visible in logs)

## Solutions to Try

### Solution 1: Enable Login Terminal (Most Likely Fix)

Cursor may be trying to show password in a terminal instead of a dialog:

1. Open Cursor Settings: `Cmd+,`
2. Search for: `remote.SSH.showLoginTerminal`
3. **Set it to `true`** (checkbox enabled)
4. Try connecting again

This shows a terminal window where you can enter the password.

### Solution 2: Check Output Panel

The password prompt might be in Cursor's output:

1. View → Output (or `Cmd+Shift+U`)
2. In the dropdown, select **"Remote-SSH"**
3. Look for password prompts or errors there
4. Try connecting and watch the output panel

### Solution 3: Enable Remote SSH Use Local Server

1. Cursor Settings (`Cmd+,`)
2. Search: `remote.SSH.useLocalServer`
3. Try toggling it (if `true`, set to `false`, or vice versa)
4. Reload window: `Cmd+Shift+P` → "Developer: Reload Window"

### Solution 4: Check macOS Accessibility Permissions

macOS might be blocking the password dialog:

1. System Settings → Privacy & Security → Accessibility
2. Make sure **Cursor** is listed and enabled
3. If not listed, click "+" and add Cursor manually

### Solution 5: Try Direct Connection String

Instead of selecting `jetson`, try typing directly:
```
m@192.168.1.207
```
This might trigger the password prompt differently.

### Solution 6: Manual Password Entry via Terminal

If nothing else works, you can set up SSH with a control socket:

1. In terminal, connect manually:
   ```bash
   ssh -M -S ~/.ssh/control-%h-%p-%r jetson
   # Enter password
   # Leave this terminal open
   ```

2. In another terminal, check control socket:
   ```bash
   ssh -S ~/.ssh/control-jetson-22-m jetson "echo connected"
   ```

3. With control socket active, try Cursor - it might reuse the connection.

### Solution 7: Use SSH Config with ControlPath

Add to `~/.ssh/config`:
```
Host jetson
    ...
    ControlMaster auto
    ControlPath ~/.ssh/control-%h-%p-%r
    ControlPersist 10m
```

Then connect once via terminal (enter password), and Cursor can reuse that connection for 10 minutes.

## Most Common Fix

**Try Solution 1 first**: Enable `remote.SSH.showLoginTerminal` in Cursor settings.
This is the most common reason password prompts don't appear - Cursor wants to show it in a terminal but that setting is disabled.
