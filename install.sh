#!/bin/bash

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="gfetch"

echo "🔧 Installing $SCRIPT_NAME..."

# 1. Make sure the bin dir exists
mkdir -p "$INSTALL_DIR"

# 2. Copy or symlink (your choice)
cp "$SCRIPT_NAME" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# 3. Check if it's in PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "⚠️  $INSTALL_DIR is not in your PATH."

    # 4. Try to detect shell and update PATH
    SHELL_RC=""
    if [[ "$SHELL" == */bash ]]; then
        SHELL_RC="$HOME/.bashrc"
    elif [[ "$SHELL" == */zsh ]]; then
        SHELL_RC="$HOME/.zshrc"
    fi

    if [[ -n "$SHELL_RC" ]]; then
        echo "🔧 Adding to your PATH in $SHELL_RC"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
        echo "✅ Done. Please restart your terminal or run: source $SHELL_RC"
    else
        echo "❓ Couldn't auto-detect your shell. Please add this to your shell config:"
        echo 'export PATH="$HOME/.local/bin:$PATH"'
    fi
else
    echo "✅ Installed! You can now run: gfetch"
fi
