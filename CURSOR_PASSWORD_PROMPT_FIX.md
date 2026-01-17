# Fix: Cursor Password Prompt Not Appearing - Step by Step

## Problem
Password prompt never appears in Cursor when connecting via Remote-SSH.

## Quick Fix - Try These in Order

### Fix 1: Enable Login Terminal (MOST IMPORTANT)

1. Open Cursor Settings: `Cmd+,` (or `Cursor` → `Settings`)
2. Search for: **`remote.SSH.showLoginTerminal`**
3. **Set it to `true`** (check the box)
4. Try connecting again

**Why**: Cursor shows the password prompt in a terminal window instead of a dialog. This setting enables that.

### Fix 2: Clear SSH Agent Keys

Run in terminal:
```bash
ssh-add -D
```

This removes any SSH keys from the agent, forcing password authentication.

### Fix 3: Check Output Panel

When trying to connect, check Cursor's output:

1. View → Output (or `Cmd+Shift+U`)
2. Dropdown: Select **"Remote-SSH"**
3. Try connecting and watch for password prompts there

### Fix 4: Try Direct Connection String

In Cursor's connection prompt, instead of selecting `jetson`, type:
```
m@192.168.1.207
```

This sometimes triggers the password prompt differently.

## Your SSH Config is Already Correct ✅

Your `~/.ssh/config` already has:
- `PubkeyAuthentication no` ✅
- `PasswordAuthentication yes` ✅
- `PreferredAuthentications password` ✅
- `IdentitiesOnly yes` ✅

So the config is fine - it's likely a Cursor UI issue.

## Most Likely Solution

**Enable `remote.SSH.showLoginTerminal` in Cursor settings.**

This is the #1 reason password prompts don't appear - Cursor wants to show it in a terminal but that feature is disabled by default on some setups.

## After Enabling Login Terminal

1. Reload Cursor window: `Cmd+Shift+P` → "Developer: Reload Window"
2. Try connecting: `Cmd+Shift+P` → "Remote-SSH: Connect to Host" → `jetson`
3. **A terminal window should open** asking for password
4. Enter: `password`

## If Still Not Working

Check these Cursor settings:
- `remote.SSH.useLocalServer`: Try toggling this
- `remote.SSH.enableDynamicForwarding`: Should be enabled
- `remote.SSH.connectTimeout`: Set to `60` or higher

## Test First

Before trying Cursor, verify terminal SSH prompts for password:
```bash
ssh jetson
# Should prompt: m@192.168.1.207's password:
```

If terminal prompts, Cursor should too after enabling `showLoginTerminal`.
