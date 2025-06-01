#!/bin/bash
set -e

# Make sure we're in the script directory (repo root)
cd "$(dirname "$0")"

echo "Creating virtual environment..."
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi

echo "Activating virtual environment and installing dependencies..."
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

chmod +x gfetch

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
cp gfetch "$BIN_DIR/"

WRAPPER="$BIN_DIR/gfetch-wrapper"
cat > "$WRAPPER" << EOF
#!/bin/bash
source "$(pwd)/.venv/bin/activate"
exec "$BIN_DIR/gfetch" "\$@"
EOF
chmod +x "$WRAPPER"

echo "Installed gfetch-wrapper in $BIN_DIR"

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
