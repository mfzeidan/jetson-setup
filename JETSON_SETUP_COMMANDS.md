# Quick Commands for Jetson Setup

## Repository Info
- **GitHub**: https://github.com/mfzeidan/jetson-setup
- **Clone**: `git clone https://github.com/mfzeidan/jetson-setup.git`

## On Your Jetson (Direct Access)

### Option 1: Clone with Git (if git is installed)
```bash
git clone https://github.com/mfzeidan/jetson-setup.git
cd jetson-setup
./setup_jetson_ssh.sh
```

### Option 2: Download Script Directly (no git needed)
```bash
curl -O https://raw.githubusercontent.com/mfzeidan/jetson-setup/main/setup_jetson_ssh.sh
chmod +x setup_jetson_ssh.sh
./setup_jetson_ssh.sh
```

### Option 3: Manual Setup (copy-paste these commands)
```bash
sudo apt update
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl status ssh
```

## After SSH Setup Works

### Test from Mac:
```bash
ssh m@192.168.1.207
# Password: password
```

### Connect via Cursor:
1. Open Cursor on Mac
2. `Cmd+Shift+P` → "Remote-SSH: Connect to Host"
3. Enter: `m@192.168.1.207` or use `jetson` if SSH config is set up
4. Password: `password`

### Clone Repo via SSH (after Cursor connection):
```bash
git clone https://github.com/mfzeidan/jetson-setup.git
cd jetson-setup
./setup_vision.sh  # Install vision libraries
python3 test_camera.py  # Test camera
```
