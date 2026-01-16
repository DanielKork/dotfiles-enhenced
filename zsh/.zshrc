# Load Zsh Environment
source ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zshenv

# Apple Silicon Homebrew fix
export PATH="/opt/homebrew/bin:$PATH"

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
[ -d /opt/homebrew/bin ] && export PATH="/opt/homebrew/bin:$PATH"

# Custom keybindings
bindkey '^o' openapp_widget
bindkey '^a' editfile_widget

# Zsh Plugins
# Syntax highlighting (install: git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting)
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto-suggestions (install: git clone https://github.com/zsh-users/zsh-autosuggestions ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions)
[ -f ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship Prompt (install: curl -sS https://starship.rs/install.sh | sh)
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=~/dotfiles-enhanced/dotfiles-enhanced/starship.toml
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

