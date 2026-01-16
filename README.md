# 🚀 Enhanced Dotfiles (Linux/macOS)

Modern, cross-platform dotfiles with beautiful prompts, powerful tools, and smart automation.

## ✨ Features

### 🎨 Modern UI
- **[Starship](https://starship.rs/)** - Beautiful, fast, and customizable prompt
- **Zsh plugins** - Syntax highlighting and auto-suggestions
- **Tmux** - Terminal multiplexer with vim-style navigation

### 🛠️ Modern CLI Tools
- **[eza](https://github.com/eza-community/eza)** - Modern `ls` replacement with icons
- **[bat](https://github.com/sharkdp/bat)** - Better `cat` with syntax highlighting
- **[fzf](https://github.com/junegunn/fzf)** - Fuzzy finder for everything
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smarter `cd` command
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - Fast grep alternative
- **[fd](https://github.com/sharkdp/fd)** - Fast find alternative

### 🎯 Smart Features
- Interactive git functions with fzf integration
- Trash system for safer file deletion
- Cross-platform app launcher (macOS/Linux)
- Comprehensive Docker shortcuts
- Automatic backups with timestamps

## 📦 Quick Setup

```bash
# Clone the repository
git clone https://github.com/DanielKork/dotfilesLinux.git ~/dotfiles-enhanced/dotfiles-enhanced

# Navigate to dotfiles
cd ~/dotfiles-enhanced/dotfiles-enhanced

# Run the setup script
./setup.sh
```

The setup script will:
1. ✅ Backup your existing dotfiles
2. ✅ Create symlinks to new configs
3. ✅ Install required dependencies
4. ✅ Set up Zsh as your default shell
5. ✅ Install modern CLI tools

## 📚 What's Included

### Configuration Files

```
dotfiles/
├── zsh/              # Zsh configuration
│   ├── .zshrc        # Main Zsh config
│   ├── .aliases      # Command aliases
│   ├── .functions    # Custom functions
│   └── .exports      # Environment variables
├── bash/             # Bash configuration
├── git/              # Git configuration
├── tmux/             # Tmux configuration
├── nvim/             # Neovim configuration
├── starship.toml     # Starship prompt config
├── ssh/              # SSH config template
├── packages/         # Package lists
│   ├── Brewfile      # macOS packages
│   └── packages.txt  # Linux packages
└── scripts/          # Installation scripts
    ├── install.sh    # Main installer
    ├── backup.sh     # Backup script
    └── test.sh       # Validation script
```

## 🎮 Keybindings

### Zsh Custom Keybindings
- `Ctrl+O` - Open application launcher
- `Ctrl+A` - Fuzzy file editor

### Tmux Keybindings
- `Ctrl+A` - Prefix key (instead of Ctrl+B)
- `Prefix + |` - Split vertically
- `Prefix + -` - Split horizontally
- `Prefix + h/j/k/l` - Navigate panes (vim-style)
- `Alt+Arrow` - Navigate panes without prefix

## 🔧 Aliases Reference

### Modern Tool Aliases
```bash
ls        # eza with icons (if installed)
ll        # eza detailed list with git status
cat       # bat with syntax highlighting
find      # fd (faster find)
cd        # zoxide (smart cd)
```

### Git Shortcuts
```bash
gs        # git status
ga        # git add
gc        # git commit
gco       # git checkout
gpu       # git push
gpl       # git pull
gl        # git log (pretty)
```

### Docker Shortcuts
```bash
d         # docker
dps       # docker ps
di        # docker images
dup       # docker compose up -d
ddown     # docker compose down
dprune    # docker system prune
```

### System Shortcuts
```bash
update    # Update system packages
cleanup   # Clean up old packages
dots      # cd ~/dotfiles-enhanced/dotfiles-enhanced
dev       # cd ~/Development
```

### Tmux Shortcuts
```bash
ta        # tmux attach
tls       # tmux list sessions
tn        # tmux new session
tk        # tmux kill session
```

## 🎯 Functions Reference

### File Management
```bash
trash <file>          # Move file to trash instead of deleting
restore <file>        # Restore file from trash
edif                  # Fuzzy find and edit file with nvim
```

### Git Functions
```bash
gac                   # Git add all + commit with message
gacp                  # Git add all + commit + push
gco                   # Interactive branch switcher (fzf)
glogf                 # Interactive git log viewer (fzf)
gstash                # Interactive stash viewer (fzf)
gquick                # Quick commit with auto-generated message
gnew <branch>         # Create and switch to new branch
gdel                  # Delete branches interactively (fzf)
gmergef               # Merge branch interactively (fzf)
```

### Application Launcher
```bash
openapp               # Launch apps with GUI picker (macOS/Linux)
```

## 🧪 Testing Your Setup

Run the validation script to check your installation:

```bash
~/dotfiles-enhanced/dotfiles-enhanced/scripts/test.sh
```

This will verify:
- ✅ Required commands are installed
- ✅ Symlinks are properly created
- ✅ Configurations are loaded
- ✅ Zsh plugins are installed

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/dotfiles-enhanced/dotfiles-enhanced
git pull
./setup.sh
```

## 📝 Customization

### Machine-Specific Settings

Create a `.zshrc.local` file for machine-specific settings that won't be tracked in git:

```bash
# ~/.zshrc.local
export CUSTOM_VAR="value"
alias custom_alias="command"
```

### SSH Configuration

Copy and customize the SSH config template:

```bash
cp ~/dotfiles-enhanced/dotfiles-enhanced/ssh/config ~/.ssh/config
# Edit ~/.ssh/config with your hosts
```

### Starship Prompt

Customize your prompt by editing:

```bash
nvim ~/dotfiles-enhanced/dotfiles-enhanced/starship.toml
```

## 🐛 Troubleshooting

### Zsh plugins not working

Install the plugins manually:

```bash
# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting

# Auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions
```

### Starship not showing

Make sure Starship is installed:

```bash
curl -sS https://starship.rs/install.sh | sh
```

### Modern tools not working

Install missing tools:

**macOS:**
```bash
brew bundle --file=~/dotfiles-enhanced/dotfiles-enhanced/packages/Brewfile
```

**Linux:**
```bash
# Install from packages.txt
sudo apt install bat eza ripgrep fd-find
```

## 📸 Screenshots

> Add screenshots of your terminal setup here!

## 🤝 Contributing

Feel free to fork and customize for your own use!

## 📄 License

MIT License - Feel free to use and modify!

## 🙏 Credits

Built with inspiration from the dotfiles community and powered by:
- [Starship](https://starship.rs/)
- [Zsh](https://www.zsh.org/)
- [Tmux](https://github.com/tmux/tmux)
- [Neovim](https://neovim.io/)
- And many other amazing open-source tools!

---

**Made with ❤️ by Daniel Korkus**
