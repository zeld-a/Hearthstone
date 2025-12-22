```
	__ _________   ___  ________ ________________  _  ______
   / // / __/ _ | / _ \/_  __/ // / __/_  __/ __ \/ |/ / __/  A Simple Arch Linux Setup Tool
  / _  / _// __ |/ , _/ / / / _  /\ \  / / / /_/ /    / _/
 /_//_/___/_/ |_/_/|_| /_/ /_//_/___/ /_/  \____/_/|_/___/    by: zeld-a

```

An automated, reproducible Arch Linux rice featuring Hyprland, with carefully curated packages and dotfiles for a beautiful and functional desktop environment.

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
- `sudo` privileges
- 'git'

### Quick Start

1. Clone the repository:
```bash
git clone https://github.com/yourusername/Hearthstone.git
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

### Installation Options

**Skip gaming packages** (for a lighter installation):
```bash
./run.sh --no-games
```

##  What It Does

1. **System Update**: Updates all existing packages
2. **Installs yay**: AUR helper for accessing community packages
3. **Package Installation**: Installs all packages from `packages.conf`
4. **Zed Editor**: Installs the Zed code editor from [Zed](https://zed.dev/install.sh)
5. **Dotfile Setup**: Clones and stows dotfiles from [arch-sama-dots](https://github.com/zeld-a/arch-sama-dots.git)

##  Project Structure

```
Hearthstone/
├── run.sh                      # Main installation script
├── packages.conf               # Package lists organized by category
├── scripts/
│   ├── install-packages.sh    # Package installation logic
│   ├── install-yay.sh         # AUR helper installation
│   ├── install-zed.sh         # Zed editor installation
│   ├── stow-dotfiles.sh       # Dotfile management
│   └── utils.sh               # Helper functions
└── README.md
```

##  Customization

### Modifying Package Lists

Edit `packages.conf` to add or remove packages in any category:
- `SYSTEM` - Core system utilities
- `DEVELOPMENT` - Development tools
- `DESKTOP` - Hyprland and related tools
- `MEDIA` - Media applications
- `FONTS` - Font packages
- `APPS` - General applications
- `GAMES` - Gaming-related packages

### Using Custom Dotfiles

Modify the `REPO_URL` in `scripts/stow-dotfiles.sh` to use your own dotfiles repository.

##  Important Notes

- This script uses `--noconfirm` flags, so it will install packages without prompting
- A system reboot is recommended after installation
- The script will create symlinks in your home directory using GNU Stow

---

Feel free to fork this repository and customize it for your own setup.

---

**Ishnu-alah.** (Good fortune to you)

**Ande'thoras-ethil.** (May your troubles be diminished)
