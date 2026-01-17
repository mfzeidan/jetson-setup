#!/bin/bash
# Test connectivity before trying Cursor connection

echo "=== Testing Jetson Connectivity ==="
echo ""

JETSON_IP="192.168.1.207"
MAX_ATTEMPTS=3

# Test ping
echo "1. Testing ping..."
PING_SUCCESS=false
for i in $(seq 1 $MAX_ATTEMPTS); do
    if ping -c 1 -W 2 "$JETSON_IP" > /dev/null 2>&1; then
        echo "   ✓ Ping successful (attempt $i)"
        PING_SUCCESS=true
        break
    else
        echo "   ✗ Ping failed (attempt $i)"
        sleep 1
    fi
done

if [ "$PING_SUCCESS" = false ]; then
    echo ""
    echo "❌ Jetson is not reachable via ping."
    echo "   - Check if Jetson is powered on"
    echo "   - Check network connection"
    echo "   - Try again when Jetson is online"
    exit 1
fi

echo ""
echo "2. Testing SSH connection..."
SSH_SUCCESS=false
for i in $(seq 1 $MAX_ATTEMPTS); do
    if ssh -o ConnectTimeout=3 -o BatchMode=yes jetson "echo test" > /dev/null 2>&1; then
        echo "   ✓ SSH successful (attempt $i)"
        SSH_SUCCESS=true
        break
    else
        # Try with password prompt (non-batch mode)
        if ssh -o ConnectTimeout=3 jetson "echo test" 2>&1 | grep -q "Welcome\|test"; then
            echo "   ✓ SSH successful (password auth, attempt $i)"
            SSH_SUCCESS=true
            break
        else
            echo "   ✗ SSH failed (attempt $i)"
            sleep 1
        fi
    fi
done

if [ "$SSH_SUCCESS" = false ]; then
    echo ""
    echo "⚠ SSH connection failed, but ping worked."
    echo "   - SSH server may not be running on Jetson"
    echo "   - Or authentication issue"
    echo ""
    echo "Try manual test: ssh jetson"
    exit 1
fi

echo ""
echo "✅ All connectivity tests passed!"
echo ""
echo "=== Now Try Connecting via Cursor ==="
echo ""
echo "1. Open Cursor"
echo "2. Press Cmd+Shift+P"
echo "3. Type: Remote-SSH: Connect to Host"
echo "4. Select: jetson"
echo "5. Enter password: password"
echo ""
echo "Connection should work now since SSH is confirmed working."
echo ""
echo "💡 Tip: Run this script right before trying Cursor connection"
echo "   to ensure network is stable: ./test_before_cursor.sh"
