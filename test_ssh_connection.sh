#!/bin/bash
# Test SSH connection from Mac to Jetson

JETSON_IP="192.168.1.207"
JETSON_USER="m"

echo "=== Testing SSH Connection to Jetson ==="
echo ""

# Test network connectivity
echo "1. Testing network connectivity (ping)..."
if ping -c 3 -W 2 "$JETSON_IP" > /dev/null 2>&1; then
    echo "   ✓ Jetson is reachable via ping"
else
    echo "   ✗ Cannot ping Jetson at $JETSON_IP"
    echo "   Make sure Jetson is online and on the same network"
    exit 1
fi

# Test SSH connection
echo ""
echo "2. Testing SSH connection..."
if ssh -o ConnectTimeout=5 -o BatchMode=no -o StrictHostKeyChecking=no "$JETSON_USER@$JETSON_IP" "echo 'SSH connection successful'; uname -a; whoami" 2>&1; then
    echo ""
    echo "   ✓ SSH connection successful!"
else
    echo ""
    echo "   ✗ SSH connection failed"
    echo ""
    echo "   Troubleshooting steps:"
    echo "   1. Make sure SSH server is running on Jetson (run setup_jetson_ssh.sh)"
    echo "   2. Check firewall settings"
    echo "   3. Verify IP address: $JETSON_IP"
    echo "   4. Try manual connection: ssh $JETSON_USER@$JETSON_IP"
    exit 1
fi

# Test Jetson system info
echo ""
echo "3. Gathering Jetson system information..."
ssh "$JETSON_USER@$JETSON_IP" << 'EOF'
    echo "   Architecture: $(uname -m)"
    echo "   Kernel: $(uname -r)"
    echo "   Glibc version: $(ldd --version | head -n 1)"
    echo "   Disk space: $(df -h ~ | tail -n 1 | awk '{print $4 " available"}')"
    echo "   Python version: $(python3 --version 2>/dev/null || echo 'not installed')"
EOF

echo ""
echo "=== All tests passed! ==="
echo "You can now proceed with Cursor Remote-SSH setup"
