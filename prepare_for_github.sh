#!/bin/bash
# Helper script to prepare and push to GitHub
# Run this after creating your GitHub repository

set -e

echo "=== Preparing for GitHub Push ==="
echo ""

# Check if remote already exists
if git remote get-url origin > /dev/null 2>&1; then
    echo "Remote 'origin' already exists:"
    git remote get-url origin
    echo ""
    read -p "Do you want to update it? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter your GitHub repository URL (https://github.com/USERNAME/REPO.git): " REPO_URL
        git remote set-url origin "$REPO_URL"
    fi
else
    read -p "Enter your GitHub repository URL (https://github.com/USERNAME/REPO.git): " REPO_URL
    git remote add origin "$REPO_URL"
fi

# Show current status
echo ""
echo "=== Current Status ==="
git status --short

echo ""
read -p "Ready to commit and push? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Commit if needed
    if [[ -n $(git status --porcelain) ]]; then
        git add .
        git commit -m "Initial commit: Jetson SSH and vision setup scripts"
    else
        echo "No changes to commit. Creating initial commit..."
        git commit --allow-empty -m "Initial commit: Jetson SSH and vision setup scripts"
    fi
    
    # Push to GitHub
    echo ""
    echo "Pushing to GitHub..."
    git branch -M main
    git push -u origin main
    
    echo ""
    echo "=== Success! ==="
    echo "Your files are now on GitHub."
    echo ""
    echo "On your Jetson, you can now run:"
    echo "  git clone $(git remote get-url origin)"
    echo "  cd $(basename $(git remote get-url origin .git))"
    echo "  ./setup_jetson_ssh.sh"
else
    echo "Cancelled. Files are staged but not pushed."
    echo ""
    echo "To push manually later, run:"
    echo "  git commit -m 'Initial commit'"
    echo "  git branch -M main"
    echo "  git push -u origin main"
fi
