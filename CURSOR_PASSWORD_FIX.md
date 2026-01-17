# Fix: Cursor Not Prompting for Password

## Problem
Cursor Remote-SSH connects to `jetson` but doesn't prompt for password. This happens because Cursor tries SSH keys first.

## Solution Applied

Updated `~/.ssh/config` to:
- ✅ Disable public key authentication (`PubkeyAuthentication no`)
- ✅ Force password authentication only
- ✅ Set `IdentitiesOnly yes` to prevent using default keys

## How to Connect Now

1. **Open Cursor**
2. **Press `Cmd+Shift+P`**
3. **Type**: `Remote-SSH: Connect to Host`
4. **Select**: `jetson`
5. **You should now see a password prompt** - enter: `password`

## If Still No Password Prompt

### Option 1: Check Cursor's Output Panel
- Look at the bottom of Cursor for connection status
- Check the "Output" panel (View → Output)
- Select "Remote-SSH" from the dropdown
- You might see authentication errors there

### Option 2: Try Manual Connection String
Instead of selecting `jetson`, try typing:
```
m@192.168.1.207
```
This might trigger password prompt differently.

### Option 3: Clear SSH Known Hosts (if needed)
If there are cached authentication issues:
```bash
ssh-keygen -R 192.168.1.207
ssh-keygen -R jetson
```

### Option 4: Check Cursor Remote-SSH Settings
1. Open Cursor Settings (`Cmd+,`)
2. Search for "remote.SSH"
3. Check:
   - `remote.SSH.useLocalServer`: Try both true/false
   - `remote.SSH.showLoginTerminal`: Set to `true` (shows terminal for password)

### Option 5: Use SSH Config with Explicit Password
If still not working, you can try adding to SSH config:
```
Host jetson
    ...
    ControlMaster auto
    ControlPath ~/.ssh/control-%h-%p-%r
```

But the current config should work - `PubkeyAuthentication no` forces password.

## Verify SSH Config

Your `~/.ssh/config` should now have:
```
Host jetson
    HostName 192.168.1.207
    User m
    PreferredAuthentications password
    PasswordAuthentication yes
    PubkeyAuthentication no
    IdentitiesOnly yes
    ...
```

## Test from Terminal First

Before trying Cursor, verify password auth works from terminal:
```bash
ssh -o PubkeyAuthentication=no jetson
# Should prompt for password
```

If terminal prompts for password, Cursor should too.
