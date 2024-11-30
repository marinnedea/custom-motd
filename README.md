
# Custom MOTD Script

This script displays system information upon user login, offering insights into system status and resource usage.

## Features

- **Operating System Details:** Displays the OS name and version.
- **Hostname and Kernel Version:** Shows the system's hostname and kernel version.
- **Uptime and User Information:** Indicates system uptime and current user details.
- **Shell and Terminal Info:** Provides information about the user's shell and terminal.
- **Hardware Specifications:** Lists CPU and GPU details.
- **Memory Usage:** Displays current memory usage.
- **System Load:** Shows the current system load average.
- **IP Address:** Displays the system's IP address.
- **Disk and Swap Usage:** Indicates usage statistics for disk and swap space.
- **Active Users and Processes:** Lists the number of active users and running processes.

## Prerequisites

Ensure the following commands are available on your system:

- `hostnamectl`
- `uname`
- `free`
- `awk`
- `lscpu`
- `lspci`
- `uptime`
- `ip`
- `df`
- `ps`
- `tty`
- `date`

## Installation

1. **Download the Script:**
   ```sh
   sudo wget -O /etc/profile.d/mymotd.sh https://raw.githubusercontent.com/marinnedea/custom-motd/master/mymotd.sh
   ```

2. **Make the Script Executable:**
   ```sh
   sudo chmod +x /etc/profile.d/mymotd.sh
   ```

## Testing the Script

To test the script without logging out and back in:

```sh
sh /etc/profile.d/mymotd.sh
```

## Customization

- **Color Scheme:** The script uses color formatting suitable for dark backgrounds. If you use a light background, adjust the ANSI color codes in the script to ensure readability.

---
## Below is a sample Light Background Color Scheme

- **Blue (for headers):** Use `\e[1;34m` → `\e[1;36m` (cyan).
- **Reset:** Use `\e[0m` (no change, as it resets all styles).
- **Yellow (optional highlights):** Use `\e[1;33m`.

Replace the relevant sections in the script to use the light background color scheme:

```sh
printf "\n"
printf "\e[1;36mOS:\e[0m %s\n" "$os_release"
printf "\e[1;36mHostname:\e[0m %s\n" "$host_name"
printf "\e[1;36mKernel:\e[0m %s\n" "$kernel_vers"
printf "\e[1;36mUptime:\e[0m %s\n" "$showup"
printf "\e[1;36mYou are logged in as:\e[0m %s\n" "$iam"
printf "\e[1;36mYour working directory is:\e[0m %s\n" "$mywd"
printf "\e[1;36mShell:\e[0m %s %s\n" "$shellinfo" "$shellvers"
printf "\e[1;36mTerminal:\e[0m %s\n" "$terminfo"
printf "\e[1;36mCPU:\e[0m %s\n" "$cpu"
[ -n "$gpu" ] && printf "\e[1;36mGPU:\e[0m %s\n" "$gpu"
printf "\e[1;36mMemory:\e[0m %s\n" "$memory"
```

### Notes:
- The cyan color (`\e[1;36m`) works well on light backgrounds without causing eye strain.
- If you want further customization (like specific colors for different sections), consider ANSI codes like `\e[0;31m` for red or `\e[0;32m` for green.
- Use `tput` to test colors interactively: 
  ```sh
  tput setaf <color-code>
  ```

### Color Code Reference

| **Color**   | **ANSI Code** | **Preview**     |
|-------------|---------------|-----------------|
| **Black**   | `\e[0;30m`    | ⬛ Black        |
| **Red**     | `\e[0;31m`    | 🟥 Red          |
| **Green**   | `\e[0;32m`    | 🟩 Green        |
| **Yellow**  | `\e[0;33m`    | 🟨 Yellow       |
| **Blue**    | `\e[0;34m`    | 🟦 Blue         |
| **Magenta** | `\e[0;35m`    | 🟪 Magenta      |
| **Cyan**    | `\e[0;36m`    | 🟦 Cyan         |
| **White**   | `\e[0;37m`    | ⬜ White        |
| **Bold**    | `\e[1m`       | **Bold**        |
| **Reset**   | `\e[0m`       | (resets style)  |

### Notes:
- The **Preview** column uses colored emojis to simulate the respective ANSI colors. While not perfectly accurate, it gives a clear visual representation.

Test your MOTD script after applying these changes to ensure the new color scheme suits your preferences.

---



## Disclaimer

This script is provided "as is" without any warranty. Use it at your own risk.
