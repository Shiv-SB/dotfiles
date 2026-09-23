#!/bin/bash
# Install oh-my-zsh, powerlevel10k, and the external zsh plugins
# referenced by dot_zshrc.tmpl. Idempotent: only clones what is missing.
# version: 2026-09-23.1
set -euo pipefail

ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH_DIR/custom}"

clone_if_missing() {
  local url="$1" dest="$2"
  if [ ! -d "$dest" ]; then
    echo "Installing $(basename "$dest")..."
    git clone --depth=1 "$url" "$dest"
  fi
}

if [ ! -d "$ZSH_DIR" ]; then
  echo "Installing oh-my-zsh..."
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
fi

mkdir -p "$ZSH_CUSTOM/plugins" "$ZSH_CUSTOM/themes"

clone_if_missing https://github.com/zsh-users/zsh-autosuggestions      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/romkatv/powerlevel10k              "$ZSH_CUSTOM/themes/powerlevel10k"
