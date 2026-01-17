# Cursor SSH Connection Issue: Shell Context

## The Problem

Cursor runs SSH commands in a shell (`sh-3.2$`), and this shell context might have:
- Different network routing
- Different environment variables
- Limited network permissions
- Different PATH or SSH configuration

## What's Happening

Cursor log shows:
```
sh-3.2$ cat "..." | ssh -T -D 50540 jetson bash --login -c bash
ssh: connect to host 192.168.1.207 port 22: No route to host
```

But `ssh jetson` from terminal works fine!

## Possible Solutions

### Solution 1: Check macOS Firewall/Security

Cursor might be blocked by macOS:
1. System Settings → Privacy & Security → Firewall
2. Make sure Cursor is allowed incoming/outgoing connections
3. If Firewall is on, try disabling temporarily to test

### Solution 2: Check Cursor Network Permissions

1. System Settings → Privacy & Security → Network
2. Look for Cursor in the list
3. Make sure it has network access enabled

### Solution 3: Check Network Interface Binding

If Mac has multiple network interfaces (WiFi + Ethernet), Cursor might bind to the wrong one.

Check your network setup:
```bash
ifconfig | grep -A 5 "inet "
netstat -rn | grep default
```

### Solution 4: Test SSH with Same Flags

Test the exact command Cursor is using:
```bash
ssh -T -D 50540 jetson "echo test"
```

Does this work from terminal?

### Solution 5: Check Environment Variables

Cursor's shell might not have the same PATH or environment. Try:
```bash
# In terminal, test with minimal env
env -i /usr/bin/ssh jetson "echo test"
```

If this fails, there's an environment issue.

## Most Likely Cause

**macOS Firewall or Network Permissions blocking Cursor**

This would explain why:
- Terminal SSH works (has permissions)
- Cursor SSH fails (blocked)

## Quick Test

1. System Settings → Privacy & Security → Firewall
2. Temporarily disable firewall
3. Try Cursor connection again
4. If it works, re-enable firewall and add Cursor exception
