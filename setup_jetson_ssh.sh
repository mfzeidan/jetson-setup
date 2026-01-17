#!/bin/bash
# Setup script to run directly on the Jetson Orin Nano
# This configures SSH server for remote access via Cursor

set -e

echo "=== Jetson SSH Setup Script ==="
echo "This script will configure SSH on your Jetson Orin Nano"
echo ""

# Update package list
echo "Updating package list..."
sudo apt update

# Install OpenSSH server if not already installed
echo "Installing OpenSSH server..."
sudo apt install -y openssh-server

# Enable and start SSH service
echo "Enabling and starting SSH service..."
sudo systemctl enable ssh
sudo systemctl start ssh

# Check SSH service status
echo ""
echo "Checking SSH service status..."
sudo systemctl status ssh --no-pager -l || true

# Configure SSH to allow password authentication
echo ""
echo "Configuring SSH to allow password authentication..."
SSH_CONFIG="/etc/ssh/sshd_config"

# Backup original config
sudo cp "$SSH_CONFIG" "${SSH_CONFIG}.backup"

# Enable password authentication
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' "$SSH_CONFIG"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' "$SSH_CONFIG"

# Enable client alive settings to prevent timeouts during Cursor server installation
sudo sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 60/' "$SSH_CONFIG"
sudo sed -i 's/ClientAliveInterval 0/ClientAliveInterval 60/' "$SSH_CONFIG"
sudo sed -i 's/#ClientAliveCountMax 3/ClientAliveCountMax 3/' "$SSH_CONFIG"
sudo sed -i 's/ClientAliveCountMax 3/ClientAliveCountMax 3/' "$SSH_CONFIG"

# Restart SSH service to apply changes
echo "Restarting SSH service..."
sudo systemctl restart ssh

# Display system information useful for troubleshooting
echo ""
echo "=== System Information ==="
echo "Architecture: $(uname -m)"
echo "Kernel: $(uname -r)"
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f 2)"
echo "Glibc version: $(ldd --version | head -n 1)"
echo "Disk space:"
df -h ~ | tail -n 1

# Check if SSH is listening on port 22
echo ""
echo "=== Network Check ==="
if sudo netstat -tlnp | grep -q ":22 "; then
    echo "✓ SSH is listening on port 22"
else
    echo "✗ SSH may not be listening on port 22"
fi

# Get IP address
echo "Current IP address(es):"
ip addr show | grep "inet " | grep -v "127.0.0.1" || hostname -I

echo ""
echo "=== Setup Complete ==="
echo "You should now be able to SSH into this Jetson from your Mac:"
echo "  ssh m@192.168.1.207"
echo ""
echo "If you have any issues, check:"
echo "  1. sudo systemctl status ssh"
echo "  2. sudo journalctl -u ssh -n 50"
echo "  3. Network connectivity (ping from Mac)"
