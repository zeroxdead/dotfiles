#!/bin/sh

printf "\033[34m"
printf "     _       _    __ _ _           \n"
sleep 0.1
printf "    | |     | |  / _(_) |          \n"
sleep 0.1
printf "  __| | ___ | |_| |_ _| | ___  ___ \n"
sleep 0.1
printf " / _  |/ _ \\| __|  _| | |/ _ \\/ __|\n"
sleep 0.1
printf "| (_| | (_) | |_| | | | |  __/\\__ \ \n"
sleep 0.1
printf " \\__,_|\\___/ \\__|_| |_|_|\\___||___/\n"
sleep 0.1
printf "\033[31m"
printf "                     by moonraccoon\n\n\n"
sleep 0.1
printf "\033[0m"
                                   
                                   

cwd=$(pwd)
printf "[\033[32m?\033[0m] Do you have \033[34mNeovim\033[0m[\033[32m>=v0.7.0\033[0m] installed? [y/N] > "
read -r nvim_installed
case "$nvim_installed" in
    [yY][eE][sS]|[yY])
        ;;
    *)
        distributions=$(lsb_release -d)
	    printf "[\033[32m+\033[0m] Installing Neovim prerequisites...\n"
        case $distributions in
            "Ubuntu" | "Debian")
                sudo apt-get install ninja-build gettext cmake unzip curl
                ;;
            "CentOS" | "RHEL" | "Fedora")
                sudo dnf -y install ninja-build cmake gcc make unzip gettext curl
                ;;
            "Arch Linux")
                sudo pacman -S base-devel cmake unzip ninja curl
                ;;
        esac

        printf "[\033[32m+\033[0m] Compiling latest Neovim...\n"
        # Clone neovim repo
        git clone https://github.com/neovim/neovim
        cd neovim
        make CMAKE_BUILD_TYPE=RelWithDebInfo -j$(nproc)
        printf "[\033[32m+\033[0m]\033[32m Done\033[0m\n"
        printf "[\033[32m+\033[0m] Installing...\n"
	    sudo make install -j$(nproc)
	    cd ..
	    rm -rf neovim
        printf "\033[32mOk\033[0m\n"
        ;;
esac

# # Install packer.nvim as a plugin manager for neovim
printf "[\033[32m+\033[0m] Installing Plugin Manager..."
printf "\033[32mOk\033[0m\n"
git clone --depth 1 https://github.com/wbthomason/packer.nvim /home/$SUDO_USER/.local/share/nvim/site/pack/packer/start/packer.nvim
# 
cp -r $cwd/nvim /home/$SUDO_USER/.config/

printf "[\033[32m+\033[0m] Installing Neovim plugins..."
nvim --headless -c "autocmd User PackerComplete quitall" -c "PackerSync" > /dev/null 2>&1
printf "\033[32mOk\033[0m\n"

printf "\n\n\033[32mConfig files written into:\n"
printf " ==> \033[31m~/.config/nvim\n\n"
printf "\033[32mThere you can select the color-scheme you want to use by uncommenting the line like so:\n\033[34m"
printf "  \033[0mvim\033[31m.\033[34mcmd \033[32m[[\n"
printf '      \033[35mcolorscheme \033[32mgruvbox-flat  <-- This theme will be used\n'
printf '      \033[36m"colorscheme everforest\n'
printf '      "colorscheme base16-material-darker\n'
printf '      "colorscheme minimal-base16\n'
printf '      "colorscheme gruvbox-material\n'
printf '      "colorscheme onedarkpro\n'
printf "  \033[32m]]\n\033[0m"
