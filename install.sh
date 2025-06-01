#!/bin/bash

set -e

echo "Setting up gfetch..."

# 1. Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

# 2. Activate venv and install dependencies
echo "Installing dependencies..."
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# 3. Make script executable
chmod +x gfetch

# 4. Copy to ~/.local/bin or create a wrapper script
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
cp gfetch "$BIN_DIR/"

echo "Installed gfetch to $BIN_DIR"

# 5. Optionally, create a wrapper script that activates venv and runs gfetch
WRAPPER="$BIN_DIR/gfetch-wrapper"
cat > "$WRAPPER" << EOF
#!/bin/bash
source "$(pwd)/.venv/bin/activate"
exec "$BIN_DIR/gfetch" "\$@"
EOF
chmod +x "$WRAPPER"

echo "You can run gfetch with: gfetch-wrapper"
echo "Or run directly with ./gfetch inside the repo."

# 6. Check if ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
    SHELL_RC=""
    if [[ "$SHELL" == */bash ]]; then
        SHELL_RC="$HOME/.bashrc"
    elif [[ "$SHELL" == */zsh ]]; then
        SHELL_RC="$HOME/.zshrc"
    fi

    if [ -n "$SHELL_RC" ]; then
        echo "Adding $BIN_DIR to your PATH in $SHELL_RC"
        echo "export PATH=\"$BIN_DIR:\$PATH\"" >> "$SHELL_RC"
        echo "Please restart your terminal or run: source $SHELL_RC"
    else
        echo "Please add $BIN_DIR to your PATH manually."
    fi
fi

echo "Setup complete!"
