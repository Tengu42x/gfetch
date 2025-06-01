#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"

echo "🔧 Installing gfetch to $INSTALL_DIR..."

mkdir -p "$INSTALL_DIR"
cp gfetch "$INSTALL_DIR"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "⚠️  $INSTALL_DIR not in PATH. Add this to your shell profile:"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
else
    echo "✅ gfetch installed! Try running: gfetch --theme retro"
fi
