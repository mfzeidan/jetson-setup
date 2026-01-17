# Cursor SSH Setup for Jetson Orin Nano

This guide helps you set up Cursor on your Mac to connect to your Jetson Orin Nano via SSH for remote development and vision capabilities exploration.

## Quick Start

### Step 1: Setup SSH on Jetson

1. **Transfer the setup script to your Jetson** (if you can access it directly via HDMI/keyboard):
   ```bash
   # On Jetson, download or copy setup_jetson_ssh.sh and run:
   chmod +x setup_jetson_ssh.sh
   ./setup_jetson_ssh.sh
   ```

   Or **manually run these commands on the Jetson**:
   ```bash
   sudo apt update
   sudo apt install -y openssh-server
   sudo systemctl enable ssh
   sudo systemctl start ssh
   sudo systemctl status ssh
   ```

2. **Verify SSH is running**:
   - SSH should be listening on port 22
   - Password authentication should be enabled

### Step 2: Test SSH from Mac

From your Mac terminal:

```bash
# Test network connectivity
ping -c 3 192.168.1.207

# Test SSH connection (use password: password)
ssh m@192.168.1.207

# Or run the test script
chmod +x test_ssh_connection.sh
./test_ssh_connection.sh
```

If SSH works, you should see a shell prompt on the Jetson.

### Step 3: Configure Cursor Remote-SSH

1. **SSH config is already set up** at `~/.ssh/config` with:
   - Host: `jetson`
   - IP: `192.168.1.207`
   - User: `m`
   - Password authentication enabled

2. **Test SSH connection using the config**:
   ```bash
   ssh jetson
   ```

3. **In Cursor**:
   - Open Cursor on your Mac
   - Press `Cmd+Shift+P` to open Command Palette
   - Type: "Remote-SSH: Connect to Host"
   - Select "jetson" from the list (or enter `jetson`)
   - Enter password when prompted: `password`

4. **Cursor Server Installation**:
   - Cursor will automatically try to install `cursor-server` on the Jetson
   - This happens in `~/.cursor-server/` on the Jetson
   - The first connection may take several minutes while it downloads and installs
   - If it hangs or fails, see Troubleshooting section below

### Step 4: Explore Vision Capabilities

Once connected via Cursor, you can explore the Jetson's vision capabilities:

```bash
# Install OpenCV
sudo apt update
sudo apt install -y python3-opencv python3-pip

# Test camera (if connected)
python3 << EOF
import cv2
cap = cv2.VideoCapture(0)
if cap.isOpened():
    ret, frame = cap.read()
    if ret:
        print(f"Camera working! Frame shape: {frame.shape}")
        cv2.imwrite('test_frame.jpg', frame)
        print("Saved test_frame.jpg")
    else:
        print("Could not read frame")
    cap.release()
else:
    print("Could not open camera")
EOF
```

## Connection Details

- **IP Address**: 192.168.1.207
- **Username**: m
- **Password**: password
- **Port**: 22 (default SSH port)
- **SSH Host Alias**: `jetson` (use `ssh jetson` from Mac)

## Files

- `setup_jetson_ssh.sh` - Script to run on Jetson to configure SSH
- `test_ssh_connection.sh` - Script to test SSH connectivity from Mac
- `~/.ssh/config` - SSH configuration file (updated for Jetson)

## Troubleshooting

### ⚠️ Cursor Shows "No route to host" but Terminal SSH Works

**Problem**: Cursor Remote-SSH shows "No route to host" but `ssh jetson` works fine from terminal.

**Solution**: **Enable Local Network permission for Cursor in macOS!**

1. **System Settings** → **Privacy & Security** → **Local Network**
2. Find **Cursor** in the application list
3. **Enable the toggle switch** (should be ON/blue)
4. Reload Cursor: `Cmd+Shift+P` → "Developer: Reload Window"
5. Try connecting again

**Why**: Terminal SSH has system-level permissions, but Cursor needs explicit Local Network access permission. This is the #1 cause of this issue!

See `CRITICAL_FIX.md` for more details.

### Connection Refused / Cannot Connect

**Problem**: `ssh: connect to host 192.168.1.207 port 22: Connection refused`

**Solutions**:
1. **SSH server not running on Jetson**:
   ```bash
   # On Jetson:
   sudo systemctl status ssh
   sudo systemctl start ssh
   sudo systemctl enable ssh
   ```

2. **Network connectivity issue**:
   ```bash
   # On Mac:
   ping 192.168.1.207
   # If ping fails, check network connection and IP address
   ```

3. **Firewall blocking SSH**:
   ```bash
   # On Jetson:
   sudo ufw allow ssh
   sudo ufw status
   ```

### Cursor Server Installation Fails or Hangs

**Problem**: Cursor hangs while "Installing Cursor Server" or shows errors about missing libraries

**Solutions**:

1. **Check glibc version compatibility**:
   ```bash
   # SSH into Jetson and check:
   ldd --version
   uname -a
   ```
   - If glibc is too old (< 2.28), Cursor's latest server may not work
   - Try an older Cursor version (0.43.6 or similar) that supports older glibc

2. **Clean and retry server installation**:
   ```bash
   # On Jetson:
   rm -rf ~/.cursor-server
   # Then try connecting again from Cursor
   ```

3. **Check disk space**:
   ```bash
   # On Jetson:
   df -h ~
   # Make sure you have at least 500MB free
   ```

4. **Check for missing dependencies**:
   ```bash
   # On Jetson:
   sudo apt install -y curl wget tar unzip
   ```

5. **Increase SSH timeout** (already configured in `~/.ssh/config`):
   - `ServerAliveInterval 60` - sends keepalive every 60 seconds
   - `ServerAliveCountMax 3` - allows 3 missed keepalives before timeout

### Authentication Failures

**Problem**: `Permission denied (password)` or similar

**Solutions**:
1. **Verify password** is correct: `password`
2. **Check SSH config allows password auth** on Jetson:
   ```bash
   # On Jetson:
   sudo grep PasswordAuthentication /etc/ssh/sshd_config
   # Should show: PasswordAuthentication yes
   ```
3. **Restart SSH service**:
   ```bash
   sudo systemctl restart ssh
   ```

### Cursor Server Segfault or Crashes

**Problem**: Server installs but crashes when starting

**Solutions**:
1. **Architecture mismatch**: Jetson Orin Nano is ARM64/aarch64. Make sure Cursor downloads the ARM64 server binary
2. **Missing shared libraries**: Check system libraries on Jetson
3. **Try older Cursor version** that has better ARM support

### SSH Timeouts During Server Installation

**Problem**: Connection drops while Cursor is installing server

**Solutions**:
1. **SSH config already includes** keepalive settings:
   ```
   ServerAliveInterval 60
   ServerAliveCountMax 3
   ```
2. **Increase timeout on Jetson SSH server**:
   ```bash
   # On Jetson:
   sudo nano /etc/ssh/sshd_config
   # Add or modify:
   ClientAliveInterval 60
   ClientAliveCountMax 3
   # Then:
   sudo systemctl restart ssh
   ```

## Next Steps: Vision Exploration

Once Cursor is connected, you can:

1. **Install vision libraries**:
   ```bash
   sudo apt install -y python3-opencv python3-pip
   pip3 install numpy matplotlib
   ```

2. **Test USB camera**:
   ```bash
   python3 -c "import cv2; print(cv2.VideoCapture(0).isOpened())"
   ```

3. **Check CSI camera** (if available):
   ```bash
   # For Jetson-specific camera tools
   gst-launch-1.0 nvarguscamerasrc ! 'video/x-raw(memory:NVMM)' ! nvvidconv ! 'video/x-raw' ! appsink
   ```

4. **Explore Jetson SDKs**:
   - JetPack includes vision-related tools
   - Check `/usr/src` for NVIDIA SDKs
   - Look for DeepStream, TensorRT examples

## Notes

- Security is intentionally minimal for this setup (password auth, no keys)
- Plan to reflash the Jetson regularly, so this is a temporary development setup
- Keep Jetson and Mac on the same network for reliable connection
- If IP address changes, update `~/.ssh/config` accordingly
