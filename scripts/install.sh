#!/bin/bash

echo "🔗 Linking dotfiles..."

# Zsh files
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.aliases ~/.aliases
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.functions ~/.functions
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.exports ~/.exports
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zprofile ~/.zprofile
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/zsh/.zshenv ~/.zshenv

# Bash files
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/bash/.bashrc ~/.bashrc
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/bash/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/bash/.bash_profile ~/.bash_profile

# Git config
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/git/.gitconfig ~/.gitconfig

# Tmux config
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/tmux/.tmux.conf ~/.tmux.conf

# Neovim config
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/nvim/init.lua ~/.config/nvim/init.lua

# Starship config
ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/starship.toml ~/.config/starship.toml

# SSH config (optional - user should customize first)
# mkdir -p ~/.ssh
# ln -sf ~/dotfiles-enhanced/dotfiles-enhanced/ssh/config ~/.ssh/config

echo "✅ Dotfiles linked successfully!"

# First: define detect_os
detect_os() {
  case "$(uname -s)" in
    Linux*)  echo linux;;
    Darwin*) echo mac;;
    *)       echo unknown;;
  esac
}

install_dependencies() {
  OS=$(detect_os)

  echo "📦 Installing dependencies for $OS..."

  if [ "$OS" = "mac" ]; then
    # macOS: use Homebrew
    if ! command -v brew >/dev/null 2>&1; then
     echo "🍺 Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# Load Homebrew path into current shell (very important!)
	echo "🔁 Adding Homebrew to PATH..."
	echo "🔁 Ensuring /opt/homebrew/bin is in PATH"
	echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
	eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  echo "📦 Installing packages from Brewfile..."
  if [ -f ~/dotfiles-enhanced/dotfiles-enhanced/packages/Brewfile ]; then
    brew bundle --file=~/dotfiles-enhanced/dotfiles-enhanced/packages/Brewfile
  else
    # Fallback to manual installation
    brew install fzf neovim zoxide bat eza ripgrep fd tmux starship git gh jq htop
  fi

  echo "🔗 Installing FZF keybindings..."
  $(brew --prefix)/opt/fzf/install --all --no-bash --no-fish

  echo "🎨 Installing Starship prompt..."
  if ! command -v starship > /dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
  fi

  elif [ "$OS" = "linux" ]; then
    # Ubuntu/Debian
    echo "📦 Updating package lists..."
    sudo apt update

    echo "📦 Installing required tools..."
    sudo apt install -y fzf neovim zsh wofi xdg-utils libgtk-3-bin bat ripgrep fd-find htop tmux jq curl wget git build-essential

    echo "🔗 Setting up FZF keybindings..."
    yes | /usr/share/doc/fzf/examples/install --no-bash --no-fish 2>/dev/null || true

    echo "🎨 Installing Starship prompt..."
    if ! command -v starship > /dev/null 2>&1; then
      curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi

    echo "📦 Installing Zoxide..."
    if ! command -v zoxide > /dev/null 2>&1; then
      curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    fi


    #sudo apt update
    #sudo apt install -y fzf neovim

    # Optional: fzf keybindings
    #yes | /usr/share/doc/fzf/examples/install --no-bash --no-fish

  else
    echo "⚠️ Unsupported OS: $OS"
  fi
}


setup_zsh() {
  # Check if zsh is installed
  if ! command -v zsh >/dev/null 2>&1; then
    echo "🐚 Installing Zsh..."
   if [ "$OS" = "mac" ]; then
      brew install zsh
    elif [ "$OS" = "linux" ]; then
      sudo apt install -y zsh
    fi
  fi

  # Set Zsh as default shell if it's not already
  if [ "$SHELL" != "$(which zsh)" ]; then
    echo "💡 Setting Zsh as default shell..."
    chsh -s "$(which zsh)" "$USER"
    echo "✅ Zsh will be your default shell next time you log in."
  else
    echo "✔️ Zsh is already your default shell."
  fi
}



