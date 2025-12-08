# blw - Battery Level Warner

A lightweight battery monitoring utility that displays persistent popup warnings when battery levels fall below critical thresholds. Built with raylib and designed for Linux systems running X11 or Wayla,d.

## Requirements

- gcc compiler
- make

## Platform Limitations

### Operating System
- **Linux only**: Uses Linux-specific battery information from `/sys/class/power_supply/BAT0/`

### Window Manager
- **Optimal**: i3 or Sway window managers with automatic configuration
- **Other WMs**: May work but window behavior (floating, always-on-top, sticky) must be configured manually
- **Desktop Environments**: May function but could conflict with built-in battery notification systems

If your OS / Distro / Window Manager isn't implemented yet, you can make a PR on this repo. \
Be sure I'll take the time to review and merge it if it's good.

## Installation

Run the build script to set up everything automatically:

```bash
./build.sh
```

This script will:
1. Install and enable cron (cronie) if not present
2. Add a cron job that runs every minute
3. Build the blw executable
4. Configure i3/Sway window rules (if applicable)

### Manual

If you want to manually download and set this up you can follows the different steps of the `build.sh` file

If there is any platform dependant error while building the project, you can refer to the `Makefile` and add raylib downloading for it. \
Do not hesitate to make a PR of it, I will review it with pleasure.

## License

This project uses raylib which is licensed under the zlib/libpng license. See `raylib-5.5_linux_amd64/LICENSE` for details.

This project is itself licensed under GPL-3.0 License. See LICENSE.md for more details 

## Author 

This project is entirely made by me (ASTOLFI Vincent). I suggest you to check on my [github profile](https://www.github.com/viastolfi) if you want to see the other project I've done for my studies or the ones I do in my free time.
