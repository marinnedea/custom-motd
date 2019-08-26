#!/bin/sh
#
clear

printf "\n"
printf "\n"

os_release="$(hostnamectl | grep -i operating | awk -F':' '{print $2}')"
host_name="$(hostnamectl | grep -i hostname | awk -F':' '{print $2}')"
kernel_vers="$(hostnamectl | grep -i kernel | awk -F':' '{print $2}')"
iam="$(whoami)"
mywd="$(pwd)"
shellinfo="$(echo $SHELL | awk -F'/' '{print $3}')"
shellinfo="${shellinfo^}"
terminfo="$(tty)"
shellvers="$($SHELL --version  | grep -i release | awk '{print $4}' | awk -F'-' '{ print $1 }')"
memory="$(free -mh | grep Mem | awk '{print $3 " / "  $2}')"
cpu="$(lscpu | grep -i "model name" | awk -F':' '{print $2}' | tr -d '[:space:]')')"
gpu="$(lspci | grep VGA | cut -d ":" -f3)"
showup="$(uptime -p | awk '{$1="" ;print}')"

echo -e "\e[1;34mOS:\e[0m $os_release" 
echo -e "\e[1;34mHostname:\e[0m $host_name"
echo -e "\e[1;34mKernel:\e[0m $kernel_vers"
#echo -e "Connected users:"
#w
echo -e "\e[1;34mUptime:\e[0m $showup"
echo -e "\e[1;34mYou are logged in as:\e[0m $iam"
echo -e "\e[1;34mYour working directory is:\e[0m $mywd"
echo -e "\e[1;34mShell:\e[0m $shellinfo $shellvers"    
echo -e "\e[1;34mTerminal:\e[0m $terminfo"
echo -e "\e[1;34mCPU:\e[0m $cpu"
echo -e "\e[1;34mGPU:\e[0m $gpu"
echo -e "\e[1;34mMemory:\e[0m $memory"



date=`date`
load=`cat /proc/loadavg | awk '{print $1}'`
root_usage=`df -h / | awk '/\// {print $(NF-1)}'`
memory_usage=`free -m | awk '/Mem:/ { total=$2 } /buffers\/cache/ { used=$3 } END { printf("%3.1f%%", used/total*100)}'`
swap_usage=`free -m | awk '/Swap/ { printf("%3.1f%%", "exit !$2;$3/$2*100") }'`
users=`users | wc -w`
time=`uptime | grep -ohe 'up .*' | sed 's/,/\ hours/g' | awk '{ printf $2" "$3 }'`
processes=`ps aux | wc -l`
ethup=$(ip -4 ad | grep 'state UP' | awk -F ":" '!/^[0-9]*: ?lo/ {print $2}')
ip=$(ip ad show dev $ethup |grep -v inet6 | grep inet|awk '{print $2}')

echo "System information as of: $date"
echo
printf "System load:\t%s\tIP Address:\t%s\n" $load $ip
printf "Memory usage:\t%s\tSystem uptime:\t%s\n" $memory_usage "$time"
printf "Usage on /:\t%s\tSwap usage:\t%s\n" $root_usage $swap_usage
printf "Local Users:\t%s\tProcesses:\t%s\n" $users $processes
echo

[ -f /etc/motd.tail ] && cat /etc/motd.tail || true
