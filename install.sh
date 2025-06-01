#!/bin/bash
set -e

# Paths
SCRIPT_NAME="gfetch"
LOCAL_BIN="$HOME/.local/bin"
TARGET="$LOCAL_BIN/$SCRIPT_NAME"

echo "Creating $LOCAL_BIN if it doesn't exist..."
mkdir -p "$LOCAL_BIN"

echo "Copying $SCRIPT_NAME to $LOCAL_BIN ..."
cp "$SCRIPT_NAME" "$TARGET"
chmod +x "$TARGET"

# Check if ~/.local/bin is in PATH
if ! echo "$PATH" | grep -q "$LOCAL_BIN"; then
  # Detect shell and rc file
  SHELL_NAME=$(basename "$SHELL")
  if [[ "$SHELL_NAME" == "bash" ]]; then
    RC_FILE="$HOME/.bashrc"
  elif [[ "$SHELL_NAME" == "zsh" ]]; then
    RC_FILE="$HOME/.zshrc"
  else
    RC_FILE=""
  fi

  if [[ -n "$RC_FILE" ]]; then
    echo "Adding $LOCAL
