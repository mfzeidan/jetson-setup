#!/bin/bash
# Test password authentication (no keys)

echo "=== Testing Password Authentication ==="
echo ""

echo "Testing SSH with password auth only (no keys)..."
echo "You should be prompted for password: password"
echo ""

ssh -o PubkeyAuthentication=no -o PreferredAuthentications=password jetson "echo 'Password authentication works!'"

echo ""
echo "If that worked, Cursor should now prompt for password too."
