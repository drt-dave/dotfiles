#!/bin/bash
# ========================================
# Dotfiles installer
# Creates symlinks and installs dependencies
# ========================================

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# --- Symlinks ---
create_link() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ]; then
    echo "  Removing old symlink: $dest"
    rm "$dest"
  elif [ -f "$dest" ]; then
    echo "  Backing up: $dest → ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi

  ln -s "$src" "$dest"
  echo "  Linked: $dest → $src"
}

echo ""
echo "=== Creating symlinks ==="
create_link "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
create_link "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# --- vim-plug ---
echo ""
echo "=== Installing vim-plug ==="
PLUG_FILE="$HOME/.vim/autoload/plug.vim"
if [ -f "$PLUG_FILE" ]; then
  echo "  vim-plug already installed"
else
  curl -fLo "$PLUG_FILE" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo "  vim-plug installed"
fi

# --- Vim plugins ---
echo ""
echo "=== Installing Vim plugins ==="
vim +PlugInstall +qall 2>/dev/null
echo "  Plugins installed"

# --- CoC extensions ---
echo ""
echo "=== Installing CoC extensions ==="
COC_DIR="$HOME/.config/coc/extensions"
mkdir -p "$COC_DIR"
if [ -f "$DOTFILES_DIR/coc-extensions.json" ]; then
  cp "$DOTFILES_DIR/coc-extensions.json" "$COC_DIR/package.json"
  cd "$COC_DIR" && npm install --ignore-scripts --no-lockfile 2>/dev/null
  echo "  CoC extensions installed"
else
  echo "  No coc-extensions.json found, skipping"
fi

echo ""
echo "Done! Open vim and enjoy."
