#!/bin/bash

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

# Go into scripts folder
cd "$SCRIPTS_DIR"

# Source the install.sh file to use its functions
source ./install.sh

# Backup old configs
./backup.sh

# Install new configs
./install.sh
install_dependencies
setup_zsh


# Reload the shell
if command -v zsh >/dev/null && [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔁 Reloading shell into Zsh..."
  exec zsh
fi
#echo "🔄 Reloading the shell..."
#exec $SHELL -l
