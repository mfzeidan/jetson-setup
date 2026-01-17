#!/usr/bin/env python3
"""
Simple camera test script for Jetson Orin Nano
Tests USB cameras and provides basic frame capture example
"""

import cv2
import sys
import os

def test_usb_camera(device_id=0):
    """Test USB camera at given device ID"""
    print(f"Testing USB camera at device {device_id}...")
    
    cap = cv2.VideoCapture(device_id)
    
    if not cap.isOpened():
        print(f"✗ Could not open camera device {device_id}")
        return False
    
    print(f"✓ Camera device {device_id} opened successfully")
    
    # Try to read a frame
    ret, frame = cap.read()
    
    if ret:
        print(f"✓ Frame captured successfully")
        print(f"  Resolution: {frame.shape[1]}x{frame.shape[0]}")
        print(f"  Channels: {frame.shape[2]}")
        
        # Save test frame
        filename = f"test_frame_{device_id}.jpg"
        cv2.imwrite(filename, frame)
        print(f"  Saved test frame: {filename}")
        
        cap.release()
        return True
    else:
        print(f"✗ Could not read frame from camera {device_id}")
        cap.release()
        return False

def find_cameras():
    """Scan for available USB cameras"""
    print("Scanning for USB cameras...")
    print("-" * 50)
    
    found_any = False
    for i in range(11):  # Check devices 0-10
        cap = cv2.VideoCapture(i)
        if cap.isOpened():
            ret, frame = cap.read()
            if ret:
                print(f"✓ Camera found at device {i}")
                print(f"  Resolution: {frame.shape[1]}x{frame.shape[0]}")
                found_any = True
            cap.release()
    
    if not found_any:
        print("✗ No USB cameras found")
        print("\nTroubleshooting:")
        print("  1. Connect a USB camera")
        print("  2. Check: lsusb (should show camera device)")
        print("  3. Check permissions: ls -l /dev/video*")
        print("  4. For CSI cameras, use Jetson-specific tools")
    
    return found_any

def main():
    """Main function"""
    print("=" * 50)
    print("Jetson Orin Nano Camera Test")
    print("=" * 50)
    print()
    
    # Check OpenCV
    print(f"OpenCV version: {cv2.__version__}")
    print()
    
    # Scan for cameras
    found_any = find_cameras()
    
    print()
    print("-" * 50)
    
    # Test first camera if found
    if found_any:
        print()
        print("Testing first available camera...")
        test_usb_camera(0)
    else:
        print()
        print("No cameras found to test.")
        print("\nFor CSI cameras on Jetson, use:")
        print("  gst-launch-1.0 nvarguscamerasrc ! 'video/x-raw(memory:NVMM)' ! nvvidconv ! 'video/x-raw' ! appsink")
    
    print()
    print("=" * 50)

if __name__ == "__main__":
    main()
