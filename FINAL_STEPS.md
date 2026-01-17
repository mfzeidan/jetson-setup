# Final Steps After SSH Key Setup

## What Just Happened

The `setup_ssh_key.sh` script should have:
1. ✅ Copied your public key to Jetson's `~/.ssh/authorized_keys`
2. ✅ Added the key to your SSH agent (visible in `ssh-add -l`)
3. ✅ Configured SSH to use the key

## Verify Setup (When Network is Up)

### Step 1: Test SSH from Terminal

When `ssh jetson` works, try:

```bash
ssh jetson
# Should connect WITHOUT password prompt now!
```

If it asks for password, the key wasn't copied. Try running `./setup_ssh_key.sh` again when SSH works.

### Step 2: Connect via Cursor (No Password Needed)

Once terminal SSH works without password:

1. Open Cursor
2. `Cmd+Shift+P` → "Remote-SSH: Connect to Host"
3. Select: `jetson`
4. **Should connect automatically - no password prompt!**

## If Password is Still Needed

### Check Key Was Copied to Jetson

On Jetson (via SSH), check:
```bash
cat ~/.ssh/authorized_keys | grep jetson-key
```

Should show your public key.

### Check SSH Config on Mac

On Mac, verify:
```bash
cat ~/.ssh/config | grep -A 5 "Host jetson"
```

Should show:
- `IdentityFile ~/.ssh/id_ed25519_jetson`
- `PreferredAuthentications publickey`

### Retry Copying Key

If key wasn't copied, when SSH works, run:
```bash
ssh-copy-id -i ~/.ssh/id_ed25519_jetson.pub m@192.168.1.207
# Password: password (one last time)
```

## Expected Behavior After Setup

✅ Terminal: `ssh jetson` - connects instantly, no password  
✅ Cursor: Remote-SSH → `jetson` - connects automatically  
✅ No password prompts needed

## Next: Connect When Network is Up

1. Test: `ssh jetson` (should work without password)
2. If works, immediately try Cursor Remote-SSH
3. Should connect automatically!

Your setup is complete - just need network to be up to test!
