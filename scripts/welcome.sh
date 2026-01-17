#!/bin/bash
# Welcome script for Dotfiles Enhanced

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
nocolor='\033[0m'

# System Info
os=$(uname -s)
kernel=$(uname -r)
uptime=$(uptime -p | sed 's/up //')
shell=$(basename "$SHELL")

if [ "$os" == "Linux" ]; then
    memory=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
elif [ "$os" == "Darwin" ]; then
    memory=$(vm_stat | perl -ne '/page size of (\d+)/; $size=$1; /Pages active:\s+(\d+)/; $active=$1; /Pages wired down:\s+(\d+)/; $wired=$1; END { printf "%.2f GB", ($active+$wired)*$size/1024/1024/1024 }')
fi

# Clear screen slightly
clear

echo -e "${PURPLE}   Dotfiles Enhanced ${nocolor}"
echo -e "${BLUE}   -----------------${nocolor}"
echo -e "   ${CYAN}OS      :${nocolor} $os"
echo -e "   ${CYAN}Kernel  :${nocolor} $kernel"
echo -e "   ${CYAN}Uptime  :${nocolor} $uptime"
echo -e "   ${CYAN}Memory  :${nocolor} $memory"
echo -e "   ${CYAN}Shell   :${nocolor} $shell"
echo ""
echo -e "${YELLOW}   🚀 Ready to code! ${nocolor}"
echo ""
