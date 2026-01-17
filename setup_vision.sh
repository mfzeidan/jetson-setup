#!/bin/bash
# Setup vision libraries on Jetson Orin Nano
# Run this via Cursor's integrated terminal once connected

set -e

echo "=== Jetson Vision Setup Script ==="
echo "This script will install vision libraries on your Jetson"
echo ""

# Update package list
echo "Updating package list..."
sudo apt update

# Install OpenCV
echo "Installing OpenCV..."
sudo apt install -y python3-opencv

# Install Python development tools
echo "Installing Python development tools..."
sudo apt install -y python3-pip python3-dev

# Install common vision/ML libraries
echo "Installing additional Python libraries..."
pip3 install --upgrade pip
pip3 install numpy matplotlib pillow

# Check OpenCV installation
echo ""
echo "=== Verification ==="
python3 << EOF
import cv2
print(f"OpenCV version: {cv2.__version__}")
import numpy as np
print(f"NumPy version: {np.__version__}")
print("✓ Vision libraries installed successfully!")
EOF

# Check camera availability
echo ""
echo "=== Camera Check ==="
python3 << 'EOF'
import cv2
import sys

# Check USB cameras (device 0-10)
found_camera = False
for i in range(11):
    cap = cv2.VideoCapture(i)
    if cap.isOpened():
        ret, frame = cap.read()
        if ret:
            print(f"✓ Camera found at device {i} (resolution: {frame.shape[1]}x{frame.shape[0]})")
            found_camera = True
            cap.release()
            break
        cap.release()

if not found_camera:
    print("⚠ No USB cameras detected")
    print("  - Connect a USB camera and try again")
    print("  - Or use Jetson CSI camera with gst-launch-1.0")

# Check CSI camera (Jetson-specific)
print("\n=== CSI Camera Check ===")
import subprocess
result = subprocess.run(['which', 'gst-launch-1.0'], capture_output=True)
if result.returncode == 0:
    print("✓ GStreamer available (can use CSI camera)")
    print("  Test with: gst-launch-1.0 nvarguscamerasrc ! 'video/x-raw(memory:NVMM)' ! nvvidconv ! 'video/x-raw' ! appsink")
else:
    print("⚠ GStreamer not found (may need JetPack installation)")
EOF

echo ""
echo "=== Setup Complete ==="
echo "You can now use OpenCV and other vision libraries in your projects"
echo "Try running a simple camera test:"
echo "  python3 -c \"import cv2; cap = cv2.VideoCapture(0); print('Camera opened:', cap.isOpened())\""
