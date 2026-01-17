#!/bin/bash
# Troubleshoot network connectivity to Jetson

JETSON_IP="192.168.1.207"

echo "=== Network Troubleshooting for Jetson ==="
echo ""

# Check Mac network info
echo "1. Mac Network Information:"
echo "   Active network interface:"
route -n get default 2>/dev/null | grep interface || ipconfig getifaddr en0 2>/dev/null | head -1

echo ""
echo "2. Testing connectivity to Jetson ($JETSON_IP):"
echo "   - Ping test..."
if ping -c 2 -W 2 "$JETSON_IP" > /dev/null 2>&1; then
    echo "   ✓ Ping successful - Jetson is reachable"
else
    echo "   ✗ Ping failed - Jetson may be offline or network issue"
fi

echo ""
echo "   - SSH test..."
if ssh -o ConnectTimeout=3 -o BatchMode=yes "$JETSON_IP" "echo test" > /dev/null 2>&1; then
    echo "   ✓ SSH successful"
else
    echo "   ✗ SSH failed - Check SSH server status on Jetson"
fi

echo ""
echo "3. Troubleshooting Steps:"
echo ""
echo "   If Jetson is not reachable:"
echo "   1. Check Jetson is powered on and connected to network"
echo "   2. Verify Jetson's IP address hasn't changed:"
echo "      (On Jetson, run: ip addr show or hostname -I)"
echo "   3. Check Jetson and Mac are on same network/subnet"
echo "   4. Try restarting SSH on Jetson:"
echo "      (On Jetson: sudo systemctl restart ssh)"
echo ""
echo "   If connection is intermittent:"
echo "   - Network may be unstable"
echo "   - Try connecting via Cursor when Jetson is reachable"
echo "   - Consider using a static IP for Jetson"

echo ""
echo "4. Test when Jetson is online:"
echo "   Run this script again when Jetson is powered on"
echo "   Then try: ssh m@$JETSON_IP"
echo "   And connect via Cursor: Cmd+Shift+P -> 'Remote-SSH: Connect to Host' -> 'jetson'"
