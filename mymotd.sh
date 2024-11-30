#!/bin/sh

# Clear the screen
clear

# Gather system information
os_release=$(hostnamectl | awk -F': ' '/Operating System/ {print $2}')
host_name=$(hostnamectl | grep -i 'hostname' | awk -F': ' '{print $2}')
kernel_vers=$(uname -r)
iam=$USER
mywd=$PWD
shellinfo=$(basename "$SHELL")
shellvers=$("$SHELL" --version 2>/dev/null | awk '/version/ {print $NF}' | head -n1)
terminfo=$(tty)
memory=$(free -mh | awk '/Mem:/ {print $3 " / " $2}')
cpu=$(awk -F': ' '/model name/ {print $2; exit}' /proc/cpuinfo)
gpu=$(lspci | awk -F': ' '/VGA compatible controller/ {print $3}')
showup=$(uptime -p | cut -d ' ' -f2-)

# Display system information
printf "\n"
printf "\e[1;34mOS:\e[0m %s\n" "$os_release"
printf "\e[1;34mHostname:\e[0m %s\n" "$host_name"
printf "\e[1;34mKernel:\e[0m %s\n" "$kernel_vers"
printf "\e[1;34mUptime:\e[0m %s\n" "$showup"
printf "\e[1;34mYou are logged in as:\e[0m %s\n" "$iam"
printf "\e[1;34mYour working directory is:\e[0m %s\n" "$mywd"
printf "\e[1;34mShell:\e[0m %s %s\n" "$shellinfo" "$shellvers"
printf "\e[1;34mTerminal:\e[0m %s\n" "$terminfo"
printf "\e[1;34mCPU:\e[0m %s\n" "$cpu"
[ -n "$gpu" ] && printf "\e[1;34mGPU:\e[0m %s\n" "$gpu"
printf "\e[1;34mMemory:\e[0m %s\n" "$memory"

# Additional system information
date=$(date)
load=$(awk '{print $1}' /proc/loadavg)
root_usage=$(df -h / | awk 'NR==2 {print $(NF-1)}')
memory_usage=$(free -m | awk '/Mem:/ {printf "%.1f%%", $3/$2*100}')
swap_usage=$(free -m | awk '/Swap:/ {printf "%.1f%%", $3/$2*100}')
users=$(users | wc -w)
time=$(uptime -p | cut -d ' ' -f2-)
processes=$(ps -e --no-headers | wc -l)
ip=$(hostname -I | awk '{print $1}')

# Display additional system information
printf "\nSystem information as of: %s\n" "$date"
printf "System load:\t%s\tIP Address:\t%s\n" "$load" "$ip"
printf "Memory usage:\t%s\tSystem uptime:\t%s\n" "$memory_usage" "$time"
printf "Usage on /:\t%s\tSwap usage:\t%s\n" "$root_usage" "$swap_usage"
printf "Local Users:\t%s\tProcesses:\t%s\n" "$users" "$processes"

# Display /etc/motd.tail if it exists
[ -f /etc/motd.tail ] && cat /etc/motd.tail
