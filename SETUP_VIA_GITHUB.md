# Setup Jetson via GitHub

Since you're using GitHub to transfer files, here's the quickest way to get the setup scripts onto your Jetson.

## Option 1: GitHub Repository (Recommended)

### On Your Mac (now):

1. **Create a new GitHub repository**:
   - Go to https://github.com/new
   - Name it something like `jetson-setup` or `jetson-orin-nano`
   - Make it public or private (your choice)
   - **Don't** initialize with README, .gitignore, or license
   - Click "Create repository"

2. **Push your local files**:
   ```bash
   cd /Users/markzeidan/Documents/source/jetson2
   
   # Add remote (replace YOUR_USERNAME and REPO_NAME with your GitHub details)
   git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
   
   # Commit files
   git commit -m "Initial commit: Jetson SSH and vision setup scripts"
   
   # Push to GitHub
   git branch -M main
   git push -u origin main
   ```

### On Your Jetson:

Once you have basic SSH access or direct console access on your Jetson:

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/REPO_NAME.git
cd REPO_NAME

# Run the SSH setup script
chmod +x setup_jetson_ssh.sh
./setup_jetson_ssh.sh
```

## Option 2: Direct Download from GitHub (No Git needed on Jetson)

If you don't want to install git on the Jetson, you can download individual files:

```bash
# On Jetson, download the setup script directly
curl -O https://raw.githubusercontent.com/YOUR_USERNAME/REPO_NAME/main/setup_jetson_ssh.sh
chmod +x setup_jetson_ssh.sh
./setup_jetson_ssh.sh
```

## Option 3: Quick Setup via SSH (If you can already SSH in)

If you can somehow get basic SSH working (maybe it's already running), you can push files directly:

```bash
# From your Mac
scp setup_jetson_ssh.sh m@192.168.1.207:~/
ssh m@192.168.1.207 "chmod +x ~/setup_jetson_ssh.sh && ~/setup_jetson_ssh.sh"
```

But if SSH isn't working yet, GitHub is the easiest way!

## After GitHub Repo is Created

Once your repo is on GitHub, update this file with your actual GitHub URL, or just remember it. Then you can easily:
- Clone it on the Jetson
- Update scripts and push changes
- Pull updates on Jetson anytime
