#!/bin/bash

# Enhanced Backup Script with Timestamps
# Backs up existing dotfiles before installing new ones

BACKUP_DIR="$HOME/dotfiles-enhanced/dotfiles-enhanced/backup/backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "📦 Backing up existing dotfiles to $BACKUP_DIR..."

# Files to backup
FILES=(
  "$HOME/.zshrc"
  "$HOME/.aliases"
  "$HOME/.functions"
  "$HOME/.exports"
  "$HOME/.zprofile"
  "$HOME/.zshenv"
  "$HOME/.bashrc"
  "$HOME/.bash_aliases"
  "$HOME/.bash_profile"
  "$HOME/.gitconfig"
  "$HOME/.tmux.conf"
  "$HOME/.config/nvim/init.lua"
  "$HOME/.config/starship.toml"
)

# Backup each file if it exists
for file in "${FILES[@]}"; do
  if [ -f "$file" ] || [ -L "$file" ]; then
    filename=$(basename "$file")
    cp -L "$file" "$BACKUP_DIR/$filename" 2>/dev/null && echo "  ✅ Backed up $filename"
  fi
done

# Create a backup info file
cat > "$BACKUP_DIR/backup-info.txt" << EOF
Backup created: $(date)
Hostname: $(hostname)
User: $USER
Shell: $SHELL

Files backed up:
$(ls -1 "$BACKUP_DIR" | grep -v backup-info.txt)
EOF

echo "✅ Backup complete!"
echo "📁 Backup location: $BACKUP_DIR"

# Keep only the last 5 backups
BACKUP_BASE="$HOME/dotfiles-enhanced/dotfiles-enhanced/backup"
BACKUP_COUNT=$(find "$BACKUP_BASE" -maxdepth 1 -type d -name "backup-*" | wc -l)

if [ "$BACKUP_COUNT" -gt 5 ]; then
  echo "🧹 Cleaning up old backups (keeping last 5)..."
  find "$BACKUP_BASE" -maxdepth 1 -type d -name "backup-*" | sort | head -n -5 | xargs rm -rf
  echo "✅ Cleanup complete!"
fi
