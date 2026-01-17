# Cursor Connection Issue: Intermittent Network Connectivity

## Problem Diagnosis

The issue is **intermittent network connectivity**, not a Cursor configuration problem:

- ✅ Terminal SSH works sometimes (you showed it works)
- ❌ Terminal SSH fails other times ("No route to host")
- ❌ Cursor tries to connect when network is down

This suggests the Jetson's network connection is unstable.

## Solution: Test Before Connecting

### Before trying Cursor:

1. **Test SSH connectivity first**:
   ```bash
   ssh jetson
   # Password: password
   ```
   If this works, Cursor will work too.

2. **Or use the test script**:
   ```bash
   ./test_before_cursor.sh
   ```
   This will verify connectivity before you try Cursor.

3. **Then immediately try Cursor**:
   - `Cmd+Shift+P` → "Remote-SSH: Connect to Host" → `jetson`
   - Password: `password`

## Possible Causes of Network Instability

1. **WiFi connection dropping**: If Jetson or Mac on WiFi, connection may be unstable
2. **Jetson going to sleep**: Power management may disconnect network
3. **Router DHCP issues**: IP address or lease renewals causing disconnects
4. **Network congestion**: Heavy traffic causing timeouts

## Troubleshooting Network Stability

### On Jetson:

1. **Check network status**:
   ```bash
   ip addr show
   # Look for your network interface (eth0, wlan0, etc.)
   ```

2. **Prevent WiFi power saving** (if on WiFi):
   ```bash
   # Check if using WiFi
   ip link show | grep wlan
   
   # If WiFi, prevent power saving (may help)
   sudo iwconfig wlan0 power off  # Replace wlan0 with your interface
   ```

3. **Check SSH service status**:
   ```bash
   sudo systemctl status ssh
   ```

4. **Check system logs for network issues**:
   ```bash
   sudo journalctl -u NetworkManager -n 50
   # or
   dmesg | tail -50
   ```

### On Mac:

1. **Test from Mac terminal right before Cursor**:
   ```bash
   ping -c 3 192.168.1.207
   ssh jetson "echo test"
   ```

2. **If ping fails but you see Jetson on network**, check:
   - Mac firewall settings
   - Network interface (WiFi vs Ethernet)
   - Router/modem status

## Quick Fix: Try Connecting Right Now

Since you confirmed SSH works from terminal, **immediately try Cursor**:

1. Open Cursor
2. `Cmd+Shift+P` → "Remote-SSH: Connect to Host"
3. Select: **`jetson`**
4. Password: **`password`**

**Do this right after a successful terminal SSH connection** - network should be stable then.

## Alternative: Use Static IP

If network instability persists, consider setting a static IP on the Jetson:

```bash
# On Jetson, edit network config
sudo nano /etc/netplan/50-cloud-init.yaml
# Add static IP configuration
```

But for now, **just try Cursor immediately after a successful SSH from terminal**.
