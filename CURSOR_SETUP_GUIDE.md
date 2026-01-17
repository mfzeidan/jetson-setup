# Quick Start Guide: Cursor SSH Connection to Jetson

## Status Check

✅ SSH config updated on Mac (`~/.ssh/config`)  
✅ Setup scripts created  
📋 Next: Run setup on Jetson and test connection

## Immediate Next Steps

### 1. Push Setup Scripts to GitHub

First, create a GitHub repository and push these files:

```bash
cd /Users/markzeidan/Documents/source/jetson2

# Option A: Use the helper script
./prepare_for_github.sh

# Option B: Manual setup
# 1. Create repo at https://github.com/new (don't initialize it)
# 2. Then run:
#    git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
#    git commit -m "Initial commit: Jetson setup scripts"
#    git branch -M main
#    git push -u origin main
```

### 2. Setup SSH on Jetson (Run directly on Jetson)

If you have direct access to your Jetson (via HDMI/keyboard or serial):

```bash
# Clone from GitHub (replace URL with your repo)
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
cd REPO_NAME
chmod +x setup_jetson_ssh.sh
./setup_jetson_ssh.sh

# OR download just the script directly (no git needed):
curl -O https://raw.githubusercontent.com/YOUR_USERNAME/REPO_NAME/main/setup_jetson_ssh.sh
chmod +x setup_jetson_ssh.sh
./setup_jetson_ssh.sh
```

**OR** manually run these commands on the Jetson:

```bash
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh
```

### 3. Test SSH from Mac

Once SSH is set up on the Jetson, test from your Mac:

```bash
# Quick test
ssh m@192.168.1.207

# Or use the test script
cd /Users/markzeidan/Documents/source/jetson2
./test_ssh_connection.sh
```

When prompted for password, enter: `password`

### 4. Connect via Cursor

Once SSH works from terminal:

1. Open Cursor on your Mac
2. Press `Cmd+Shift+P` (Command Palette)
3. Type: `Remote-SSH: Connect to Host`
4. Select: `jetson` (or enter `m@192.168.1.207`)
5. Enter password: `password`

Cursor will automatically try to install `cursor-server` on the Jetson. This may take a few minutes.

### 5. If Connection Issues

See `README.md` for detailed troubleshooting. Common issues:

- **Connection refused**: SSH server not running on Jetson
- **Password auth fails**: Run `setup_jetson_ssh.sh` on Jetson
- **Cursor server hangs**: Check glibc version compatibility (see README)

### 6. Setup Vision Libraries (Once Connected)

After Cursor is connected, in Cursor's terminal on Jetson:

```bash
# Run the vision setup script
./setup_vision.sh

# Or manually:
sudo apt install -y python3-opencv python3-pip
pip3 install numpy matplotlib

# Test camera
python3 test_camera.py
```

## Files Created

- `setup_jetson_ssh.sh` - Run on Jetson to configure SSH
- `test_ssh_connection.sh` - Run on Mac to test SSH
- `setup_vision.sh` - Run on Jetson (via Cursor) to install vision libraries
- `test_camera.py` - Python script to test camera
- `README.md` - Complete documentation and troubleshooting
- `~/.ssh/config` - Updated SSH configuration for Jetson

## Connection Details

- **SSH Host**: `jetson` (use `ssh jetson` or select in Cursor)
- **IP**: 192.168.1.207
- **User**: m
- **Password**: password
