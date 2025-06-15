#!/bin/bash
set -e

AGENT_URL="https://raw.githubusercontent.com/ksat-design/meshcentral-agent-zips/main/meshagent"
INSTALL_DIR="$HOME/meshagent-install"
cd "$HOME"
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo "↘ Downloading MeshAgent..."
curl -sSL -o meshagent "$AGENT_URL"
chmod +x meshagent

echo "🛠  Installing MeshAgent as launch daemon..."
sudo ./meshagent -install

echo "🧹 Cleaning up install files..."
cd "$HOME"
rm -rf "$INSTALL_DIR"

echo "✅ MeshAgent installed."

# GUI popup using AppleScript
osascript <<EOF
display dialog "MeshAgent has been successfully installed and is now running in the background." buttons {"OK"} default button "OK" with title "Installation Complete" with icon note
EOF
