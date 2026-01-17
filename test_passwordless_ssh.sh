#!/bin/bash
# Test if passwordless SSH is working

echo "=== Testing Passwordless SSH ==="
echo ""

echo "Test 1: Testing SSH connection with key..."
if ssh -o ConnectTimeout=5 -o BatchMode=yes jetson "echo 'Passwordless SSH works!'" 2>/dev/null; then
    echo "✅ Passwordless SSH is working!"
    echo ""
    echo "You should now be able to connect via Cursor without password!"
    echo ""
    echo "Try connecting in Cursor:"
    echo "  1. Cmd+Shift+P → 'Remote-SSH: Connect to Host'"
    echo "  2. Select: jetson"
    echo "  3. Should connect automatically (no password prompt)"
    exit 0
else
    echo "❌ Passwordless SSH is not working"
    echo ""
    echo "Testing with verbose output..."
    ssh -v jetson "echo test" 2>&1 | grep -i "authentic\|permission\|denied" | head -5
    echo ""
    echo "The key may not be on the Jetson yet."
    echo "If terminal SSH works with password, run: ./setup_ssh_key.sh"
    exit 1
fi
