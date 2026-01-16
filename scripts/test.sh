#!/bin/bash

# Dotfiles Testing & Validation Script
# Validates that dotfiles are properly installed and configured

echo "🧪 Testing dotfiles installation..."
echo ""

ERRORS=0
WARNINGS=0

# Color codes
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Test function
test_command() {
  local cmd=$1
  local name=$2
  if command -v "$cmd" &> /dev/null; then
    echo -e "${GREEN}✅ $name is installed${NC}"
    return 0
  else
    echo -e "${YELLOW}⚠️  $name is not installed${NC}"
    ((WARNINGS++))
    return 1
  fi
}

# Test symlink
test_symlink() {
  local link=$1
  local name=$2
  if [ -L "$link" ]; then
    echo -e "${GREEN}✅ $name is linked${NC}"
    return 0
  elif [ -f "$link" ]; then
    echo -e "${YELLOW}⚠️  $name exists but is not a symlink${NC}"
    ((WARNINGS++))
    return 1
  else
    echo -e "${RED}❌ $name is missing${NC}"
    ((ERRORS++))
    return 1
  fi
}

echo "📋 Checking required commands..."
test_command "zsh" "Zsh"
test_command "git" "Git"
test_command "fzf" "FZF"
test_command "nvim" "Neovim"

echo ""
echo "📋 Checking optional modern tools..."
test_command "starship" "Starship"
test_command "zoxide" "Zoxide"
test_command "bat" "Bat"
test_command "eza" "Eza"
test_command "ripgrep" "Ripgrep"
test_command "tmux" "Tmux"

echo ""
echo "📋 Checking symlinks..."
test_symlink "$HOME/.zshrc" ".zshrc"
test_symlink "$HOME/.gitconfig" ".gitconfig"
test_symlink "$HOME/.tmux.conf" ".tmux.conf"

echo ""
echo "📋 Checking Zsh configuration..."
if [ -f "$HOME/.zshrc" ]; then
  if grep -q "starship" "$HOME/.zshrc"; then
    echo -e "${GREEN}✅ Starship is configured in .zshrc${NC}"
  else
    echo -e "${YELLOW}⚠️  Starship not found in .zshrc${NC}"
    ((WARNINGS++))
  fi
  
  if grep -q "zoxide" "$HOME/.zshrc"; then
    echo -e "${GREEN}✅ Zoxide is configured in .zshrc${NC}"
  else
    echo -e "${YELLOW}⚠️  Zoxide not found in .zshrc${NC}"
    ((WARNINGS++))
  fi
fi

echo ""
echo "📋 Checking Zsh plugins..."
if [ -d "$HOME/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting" ]; then
  echo -e "${GREEN}✅ zsh-syntax-highlighting is installed${NC}"
else
  echo -e "${YELLOW}⚠️  zsh-syntax-highlighting not installed${NC}"
  echo "   Install with: git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-syntax-highlighting"
  ((WARNINGS++))
fi

if [ -d "$HOME/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions" ]; then
  echo -e "${GREEN}✅ zsh-autosuggestions is installed${NC}"
else
  echo -e "${YELLOW}⚠️  zsh-autosuggestions not installed${NC}"
  echo "   Install with: git clone https://github.com/zsh-users/zsh-autosuggestions ~/dotfiles-enhanced/dotfiles-enhanced/zsh-plugins/zsh-autosuggestions"
  ((WARNINGS++))
fi

echo ""
echo "📋 Checking shell..."
if [ "$SHELL" = "$(which zsh)" ]; then
  echo -e "${GREEN}✅ Zsh is the default shell${NC}"
else
  echo -e "${YELLOW}⚠️  Zsh is not the default shell (current: $SHELL)${NC}"
  echo "   Set with: chsh -s \$(which zsh)"
  ((WARNINGS++))
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Test Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Errors: ${RED}$ERRORS${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo -e "\n${GREEN}🎉 All tests passed! Your dotfiles are properly configured.${NC}"
  exit 0
elif [ $ERRORS -eq 0 ]; then
  echo -e "\n${YELLOW}⚠️  Tests passed with warnings. Some optional features are missing.${NC}"
  exit 0
else
  echo -e "\n${RED}❌ Tests failed. Please fix the errors above.${NC}"
  exit 1
fi
