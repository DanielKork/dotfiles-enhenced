# Load Zsh Environment
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zshenv ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zshenv

# Load Exports
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.exports ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.exports

# Load Aliases
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.aliases ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.aliases

# Load Functions
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.functions ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.functions

# Load Zprofile (for login shells)
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zprofile ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zprofile

# Load FZF if available
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/fzf/fzf.bash ] && source ~/dotfiles-enhanced/dotfiles-enhanced/fzf/fzf.bash

# Load Zoxide if available
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zoxide/zoxide.bash ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zoxide/zoxide.bash

# Initialize Zoxide (modern cd replacement)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'  # Replace cd with zoxide
fi

# Apple Silicon Homebrew support
if [ -d /opt/homebrew/bin ]; then
  export PATH="/opt/homebrew/bin:$PATH"
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null
fi

# Intel Mac Homebrew support
if [ -d /usr/local/bin ]; then
  export PATH="/usr/local/bin:$PATH"
fi

# Custom keybindings
bindkey '^o' openapp_widget 2>/dev/null
bindkey '^a' editfile_widget 2>/dev/null

# Zsh Plugins
# Syntax highlighting (install: git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting)
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto-suggestions (install: git clone https://github.com/zsh-users/zsh-autosuggestions ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions)
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship Prompt (install: curl -sS https://starship.rs/install.sh | sh)
# IMPORTANT: Set config BEFORE init
export STARSHIP_CONFIG=~/dotfiles-enhanced/dotfiles-enhanced/starship.toml
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  # Fallback to basic prompt if Starship not installed
  autoload -Uz colors && colors
  PROMPT="%F{green}%n%f@%F{blue}%~%f %# "
fi

# Zsh options
setopt AUTO_CD              # Auto cd when typing just a path
setopt HIST_IGNORE_DUPS     # Don't record duplicate commands
setopt HIST_FIND_NO_DUPS    # Don't show duplicates in search
setopt SHARE_HISTORY        # Share history between sessions
setopt APPEND_HISTORY       # Append to history file
setopt INC_APPEND_HISTORY   # Add commands immediately


# Welcome Message
if [ -f ~/dotfiles-enhanced/dotfiles-enhanced/scripts/welcome.sh ]; then
  ~/dotfiles-enhanced/dotfiles-enhanced/scripts/welcome.sh
fi
