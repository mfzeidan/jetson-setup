# Cursor Connection Tips

## Current Issue: "No route to host"

The Jetson appears to be offline or unreachable from your Mac right now. This explains why Cursor can't connect.

## Quick Checklist

### When Jetson is Online:
1. ✅ **Test SSH from terminal first**:
   ```bash
   ssh m@192.168.1.207
   ```
   If this works, then Cursor should work too.

2. ✅ **Connect via Cursor using the `jetson` alias**:
   - `Cmd+Shift+P` → "Remote-SSH: Connect to Host"
   - Select: **`jetson`** (this uses your SSH config with keepalive settings)
   - Or type: `m@192.168.1.207`

3. ✅ **Wait for cursor-server installation**:
   - First connection takes 2-5 minutes
   - Cursor downloads and installs server on Jetson
   - You'll see progress in the terminal/output panel

### If Connection Fails:

**"No route to host" or "Connection refused":**
- Jetson may be offline or IP changed
- Check: `ping 192.168.1.207` from Mac
- Verify Jetson is powered on and on network
- Check Jetson IP: `ip addr show` (on Jetson) or check router DHCP table

**"Authentication failed":**
- Password is: `password`
- Make sure SSH password auth is enabled (already done by setup script)

**Cursor server installation hangs:**
- Wait at least 5 minutes on first connection
- Check Jetson disk space: `df -h ~` (on Jetson)
- Check network speed - slow connection = slower download
- If stuck, try: `rm -rf ~/.cursor-server` (on Jetson) and reconnect

**Connection drops during installation:**
- SSH config already has keepalive (`ServerAliveInterval 60`)
- Make sure Jetson stays online during installation

## Best Practices

1. **Always test terminal SSH first** before trying Cursor
2. **Use the `jetson` alias** in Cursor (uses optimized SSH config)
3. **Keep Jetson powered on** during initial setup
4. **Check network stability** - unstable WiFi can cause disconnects

## Troubleshooting Script

Run the troubleshooting script:
```bash
./troubleshoot_connection.sh
```

This will help diagnose network connectivity issues.
