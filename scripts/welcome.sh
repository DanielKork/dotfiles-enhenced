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
shell=$(basename "$SHELL")

if [ "$os" == "Linux" ]; then
    uptime_raw=$(uptime -p 2>/dev/null | sed 's/up //')
    if [ -z "$uptime_raw" ]; then
      uptime_raw=$(uptime | awk -F'( |,|:)+' '{print $6"h "$7"m"}')
    fi
    memory=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
elif [ "$os" == "Darwin" ]; then
    # macOS uptime parsing
    boot_time=$(sysctl -n kern.boottime | awk '{print $4}' | tr -d ',')
    now=$(date +%s)
    uptime_secs=$((now - boot_time))
    uptime_days=$((uptime_secs / 86400))
    uptime_hours=$(( (uptime_secs % 86400) / 3600 ))
    uptime_mins=$(( (uptime_secs % 3600) / 60 ))
    if [ $uptime_days -gt 0 ]; then
      uptime_raw="${uptime_days}d ${uptime_hours}h ${uptime_mins}m"
    else
      uptime_raw="${uptime_hours}h ${uptime_mins}m"
    fi
    # macOS memory
    memory=$(vm_stat | perl -ne '/page size of (\d+)/; $size=$1; /Pages active:\s+(\d+)/; $active=$1; /Pages wired down:\s+(\d+)/; $wired=$1; END { printf "%.1f GB", ($active+$wired)*$size/1024/1024/1024 }')
fi

# Clear screen slightly
clear

echo -e "${PURPLE}   Dotfiles Enhanced ${nocolor}"
echo -e "${BLUE}   -----------------${nocolor}"
echo -e "   ${CYAN}OS      :${nocolor} $os"
echo -e "   ${CYAN}Kernel  :${nocolor} $kernel"
echo -e "   ${CYAN}Uptime  :${nocolor} $uptime_raw"
echo -e "   ${CYAN}Memory  :${nocolor} $memory"
echo -e "   ${CYAN}Shell   :${nocolor} $shell"
echo ""
echo -e "${YELLOW}   🚀 Ready to code! ${nocolor}"
echo ""
