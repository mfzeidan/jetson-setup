# SSH Key Setup - No Password Needed

I've created an SSH key pair that will allow passwordless authentication to your Jetson.

## Quick Setup (When Jetson is Online)

Run this script when SSH works from terminal:

```bash
./setup_ssh_key.sh
```

This script will:
1. Copy your public key to Jetson (requires password **once**: `password`)
2. Configure your SSH to use the key
3. Test the connection

## Manual Setup (If Script Fails)

### Step 1: Copy Public Key to Jetson

When `ssh jetson` works, run:

```bash
ssh-copy-id -i ~/.ssh/id_ed25519_jetson.pub m@192.168.1.207
# Password: password
```

Or manually:

```bash
cat ~/.ssh/id_ed25519_jetson.pub | ssh m@192.168.1.207 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
# Password: password
```

### Step 2: Test Connection

```bash
ssh jetson
# Should connect WITHOUT password prompt now!
```

### Step 3: Add Key to SSH Agent (Optional)

```bash
ssh-add ~/.ssh/id_ed25519_jetson
```

## What Changed

- ✅ Created SSH key: `~/.ssh/id_ed25519_jetson`
- ✅ Updated SSH config to use this key
- ⏳ Need to copy public key to Jetson (run `setup_ssh_key.sh`)

## After Setup

Once the key is on the Jetson:
- ✅ Terminal SSH will work without password
- ✅ Cursor Remote-SSH will work without password prompt
- ✅ No more password entry needed!

## Connection

After setup, just:
1. `Cmd+Shift+P` → "Remote-SSH: Connect to Host" → `jetson`
2. **No password prompt** - connects automatically!

## Your Public Key

Your public key is:
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINT1RIxmbblHkkC+8h43rrVesRdiDu1Jkc5laDtqP5UZ jetson-key
```

This needs to be added to `~/.ssh/authorized_keys` on the Jetson.
