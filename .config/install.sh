#!/bin/bash

# Update and install dependencies
sudo zypper refresh && sudo zypper update -y
sudo zypper install -y zsh git curl wget unzip tmux eza neovim

# Set Zsh as default shell
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/refs/heads/master/oh-my-zsh.sh)"

# Install Spaceship Zsh theme
git clone https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt
ln -s $ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme $ZSH_CUSTOM/themes/spaceship.zsh-theme
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="spaceship"/' ~/.zshrc

echo 'alias ls="eza --icons --group-directories-first --color=auto --git --long --time-style=long-iso"' >> ~/.zshrc
echo 'alias la="eza --icons --group-directories-first --git --color=auto --long --all"' >> ~/.zshrc

source ~/.zshrc

# Install Nerd Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip Meslo.zip && rm Meslo.zip
fc-cache -fv

# Install LazyVim for Neovim
git clone https://github.com/JobyCJohn/LazyVim.git ~/.config/nvim
nvim

# Install Tmux Plugin Manager (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
