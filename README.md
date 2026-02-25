```
	  __ _________   ___  ________ ________________  _  ______
   / // / __/ _ | / _ \/_  __/ // / __/_  __/ __ \/ |/ / __/  A Simple Arch Linux Setup Tool
  / _  / _// __ |/ , _/ / / / _  /\ \  / / / /_/ /    / _/
 /_//_/___/_/ |_/_/|_| /_/ /_//_/___/ /_/  \____/_/|_/___/    by: zeld-a

```

An automated, reproducible Arch Linux setup script featuring hyprland.

##  Features

- **Automated Installation**: One command to set up your entire system
- **Hyprland Desktop**: Modern Wayland compositor with beautiful animations
- **Curated Package List**: Essential tools for development, media, and daily use
- **Dotfile Management**: Automatically clones and stows [arch-sama-dots](https://github.com/zeld-a/arch-sama-dots.git)
- **Optional Gaming Setup**: Install gaming tools with a single flag
- **Reproducible**: Easy to replicate your setup across multiple machines

##  Installation

### Prerequisites
- Fresh Desktop Hyprland profile Arch Linux installation 
- Internet connection
- Must be run as root

### Quick Start

1. Clone the repository:
```bash
git clone https://github.com/zeld-a/Hearthstone.git
cd Hearthstone
```

2. Make the run script executable:
```bash
chmod +x run.sh
```

3. Run the installation:
```bash
./run.sh
```

##  What It Does

1. **System Update**: Updates all existing packages
2. **Installs yay**: AUR helper for accessing community packages
3. **Package Installation**: Installs all packages defined in `packages.conf`
4. **Zed Editor**: Installs the Zed code editor from [Zed](https://zed.dev/download)
5. **Dotfile Setup**: Clones and stows dotfiles from the specified dotfiles repo defined in 'packages.conf' *Default:* [arch-sama-dots](https://github.com/zeld-a/arch-sama-dots.git)

##  Project Structure

```
Hearthstone/
├── run.sh                      # Main installation script
├── packages.conf               # Package lists and config
├── scripts/
│   ├── enable-services.sh     # Service configuration
│   ├── install-packages.sh    # Package installation logic
│   ├── install-yay.sh         # AUR helper installation
│   ├── stow-dotfiles.sh       # Dotfile management
│   └── utils.sh               # Helper functions
└── README.md
```

##  Customization

### Modifying Package Lists

Edit `packages.conf` to add or remove packages and services in any category:
- `SYS_UTILS` - Core system utilities
- `DEV_TOOLS` - Development tools
- `TOOLCHAINS` - Compilers and runtimes
- `DESKTOP` - Hyprland and related tools
- `FONTS` - Font packages
- `APPS` - General applications
- `SERVICES` - System services
- `USER_SERVICES` - User services

### Using Custom Dotfiles

Modify the `DOTFILES_URL` in `packages.conf` to use your own dotfiles repository.

##  Important Notes

- This script uses `--noconfirm` flags, so it will install packages without prompting
- A system reboot is recommended after installation
- The script will create symlinks in your home directory using GNU Stow

---

Feel free to fork this repository and customize it for your own setup.

---

**Ishnu-alah.** (Good fortune to you)

**Ande'thoras-ethil.** (May your troubles be diminished)
