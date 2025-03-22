#!/bin/bash
set -e

echo "🔧 Starting Zsh environment setup..."

# Directories and files
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/}"
OMP_CONFIG_DIR="$HOME/.oh-my-posh"
OMP_THEME="spaceship.omp.json"
OMP_THEME_URL="https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/spaceship.omp.json"

# Install zsh plugins if missing
for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search; do
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
    echo "Installing $plugin..."
    git clone "https://github.com/zsh-users/$plugin" "$ZSH_CUSTOM/plugins/$plugin"
  else
    echo "$plugin already installed."
  fi
done

# Install oh-my-posh CLI if missing
if ! command -v oh-my-posh >/dev/null; then
  echo "📦 Installing oh-my-posh..."
  wget https://ohmyposh.dev/install.sh -O - | bash
else
  echo "✅ oh-my-posh already installed."
fi

# Download spaceship theme config for oh-my-posh if missing
mkdir -p "$OMP_CONFIG_DIR"
if [ ! -f "$OMP_CONFIG_DIR/$OMP_THEME" ]; then
  echo "📥 Downloading oh-my-posh theme: $OMP_THEME"
  curl -fsSL "$OMP_THEME_URL" -o "$OMP_CONFIG_DIR/$OMP_THEME"
else
  echo "✅ oh-my-posh theme already exists."
fi

echo "✅ Setup complete! Please reload your shell or run: source ~/.zshrc"
