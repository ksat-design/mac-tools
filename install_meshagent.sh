#!/bin/bash
set -e

# GitHub-hosted universal macOS MeshAgent binary
AGENT_URL="https://raw.githubusercontent.com/ksat-design/meshcentral-agent-zips/main/meshagent"

INSTALL_DIR="$HOME/meshagent-install"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo "↘ Downloading MeshAgent..."
curl -sSL -o meshagent "$AGENT_URL"
chmod +x meshagent

echo "🔌 Connecting MeshAgent..."
sudo ./meshagent -connect

echo "🛠  Installing MeshAgent as launch daemon..."
sudo ./meshagent -install

echo "✅ MeshAgent setup complete."
