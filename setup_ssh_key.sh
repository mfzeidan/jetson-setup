#!/bin/bash
# Setup SSH key authentication to Jetson (no password needed)

echo "=== Setting up SSH Key Authentication ==="
echo ""

PUBLIC_KEY_FILE="$HOME/.ssh/id_ed25519_jetson.pub"
PUBLIC_KEY=$(cat "$PUBLIC_KEY_FILE")

echo "1. Copying SSH public key to Jetson..."
echo "   (This will require entering password once: 'password')"
echo ""

# Copy the public key to Jetson's authorized_keys
ssh m@192.168.1.207 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '$PUBLIC_KEY' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && echo 'SSH key added successfully!'" || {
    echo "❌ Failed to copy key. Make sure:"
    echo "   - Jetson is online and reachable"
    echo "   - SSH works: ssh m@192.168.1.207"
    exit 1
}

echo ""
echo "✅ SSH key copied to Jetson!"
echo ""

# Add key to ssh-agent
echo "2. Adding key to SSH agent..."
ssh-add ~/.ssh/id_ed25519_jetson 2>&1 || echo "Note: ssh-add may prompt for key passphrase (press Enter if blank)"

echo ""
echo "3. Testing passwordless connection..."
if ssh -o ConnectTimeout=5 jetson "echo 'Passwordless SSH works!'" 2>/dev/null; then
    echo "✅ Passwordless SSH is working!"
    echo ""
    echo "You can now connect via Cursor without entering password!"
else
    echo "⚠️  Test failed. Trying again with verbose output..."
    ssh -v jetson "echo test" 2>&1 | grep -i "authentic\|permission" | head -3
fi

echo ""
echo "=== Setup Complete ==="
echo "Now try connecting via Cursor - no password should be needed!"
