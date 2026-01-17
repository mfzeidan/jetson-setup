# Final Connection Guide: Cursor to Jetson

## The Real Issue

**Network connectivity is intermittent**. Your SSH config is correct, but the Jetson isn't always reachable.

The good news: When network IS working, Cursor will connect!

## Simple Workflow

### Option 1: Manual Test (Quick)

1. **Open a terminal** and test SSH:
   ```bash
   ssh jetson
   # Password: password
   ```

2. **If SSH connects successfully**, IMMEDIATELY:
   - Open Cursor
   - `Cmd+Shift+P` → "Remote-SSH: Connect to Host"
   - Select: `jetson`
   - Password: `password`

3. **If SSH fails** ("No route to host"), wait a moment and try again.

### Option 2: Use the Workflow Script

```bash
./connect_cursor_workflow.sh
```

This script:
- Tests SSH connectivity (multiple attempts)
- Tells you when network is up
- Guides you to connect via Cursor immediately

## Why This Works

- ✅ SSH config is correct (`~/.ssh/config` with `jetson` alias)
- ✅ Password authentication is configured (`PubkeyAuthentication no`)
- ✅ Cursor's askpass server is working (you see it in logs)
- ❌ Network connectivity is intermittent (Jetson goes offline/online)

**Solution**: Connect via Cursor WHEN the network is working.

## Signs Network is Working

- Terminal `ssh jetson` connects successfully
- Ping works: `ping -c 1 192.168.1.207`
- Jetson monitor shows it's online

## Signs Network is Down

- Terminal SSH fails with "No route to host"
- Ping fails
- Cursor shows "No route to host" error

## When to Try Cursor

✅ **DO try Cursor** when:
- Terminal SSH works
- You can ping the Jetson
- Jetson appears online

❌ **DON'T try Cursor** when:
- Terminal SSH fails
- Ping fails
- Network is clearly down

## Summary

1. Test: `ssh jetson` (from terminal)
2. If works → **immediately** connect via Cursor
3. If fails → wait and retry

The network needs to be up at the moment Cursor tries to connect. When it is, Cursor will work perfectly!
