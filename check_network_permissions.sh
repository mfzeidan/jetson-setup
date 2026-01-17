#!/bin/bash
# Check network permissions and settings

echo "=== Network Permissions Check ==="
echo ""

echo "1. Active Network Interfaces:"
ifconfig | grep "inet " | grep -v 127.0.0.1
echo ""

echo "2. Network Services:"
networksetup -listallnetworkservices 2>&1 | grep -v "asterisk"
echo ""

echo "3. Default Route:"
netstat -rn | grep default | head -2
echo ""

echo "4. Can reach Jetson?"
ping -c 2 -W 2 192.168.1.207 2>&1 | head -5
echo ""

echo "5. SSH test:"
ssh -o ConnectTimeout=3 jetson "echo 'SSH works!'" 2>&1 | head -3
echo ""

echo "=== Manual Checks ==="
echo ""
echo "Check these in System Settings:"
echo "1. Privacy & Security → Local Network"
echo "   - Make sure Cursor is enabled"
echo ""
echo "2. Privacy & Security → Network"
echo "   - Check network permissions for apps"
echo ""
echo "3. Network → Wi-Fi → Advanced"
echo "   - Check if 'Limit IP address tracking' is affecting connections"
echo ""
