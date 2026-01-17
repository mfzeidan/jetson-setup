#!/bin/bash
# Workflow: Test SSH, then guide Cursor connection

echo "=== Cursor Connection Workflow ==="
echo ""

echo "Step 1: Testing SSH connectivity..."
echo ""

# Test SSH with 3 attempts
SUCCESS=false
for i in {1..3}; do
    echo "Attempt $i..."
    if ssh -o ConnectTimeout=5 -o BatchMode=no jetson "echo 'Connected successfully!'" 2>/dev/null; then
        echo "✅ SSH connection successful!"
        SUCCESS=true
        break
    else
        echo "❌ SSH connection failed"
        if [ $i -lt 3 ]; then
            echo "   Waiting 2 seconds before retry..."
            sleep 2
        fi
    fi
done

echo ""

if [ "$SUCCESS" = true ]; then
    echo "✅✅✅ NETWORK IS UP - CONNECT VIA CURSOR NOW! ✅✅✅"
    echo ""
    echo "1. Open Cursor"
    echo "2. Press Cmd+Shift+P"
    echo "3. Type: Remote-SSH: Connect to Host"
    echo "4. Select: jetson"
    echo "5. Password: password"
    echo ""
    echo "⚠️  Do this IMMEDIATELY while network is working!"
    echo "    (The network might go down again in a few moments)"
else
    echo "❌ Network is not reachable right now."
    echo ""
    echo "Troubleshooting:"
    echo "- Check if Jetson is powered on"
    echo "- Verify Jetson is on the network (check monitor)"
    echo "- Run this script again: ./connect_cursor_workflow.sh"
    echo ""
    echo "The Jetson connection appears to be intermittent."
    echo "Keep trying this script until SSH works, then immediately connect via Cursor."
fi
