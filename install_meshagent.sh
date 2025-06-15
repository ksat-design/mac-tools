#!/bin/bash

set -e

# Update with your actual MeshCentral hostname
SERVER_HOST="remote.ksatdesign.com.au"

# Paths to agent zip files (replace with your actual URLs)
AGENT_X64_URL="https://${SERVER_HOST}/meshagents?id=4&type=mac-x64"
AGENT_ARM64_URL="https://${SERVER_HOST}/meshagents?id=4&type=mac-arm64"

# Download folder
INSTALL_DIR="$HOME/meshagent-install"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

# Detect architecture
ARCH=$(uname -m)

if [[ "$ARCH" == "arm64" ]]; then
    echo "Detected Apple Silicon (arm64)"
    AGENT_URL="$AGENT_ARM64_URL"
elif [[ "$ARCH" == "x86_64" ]]; then
    echo "Detected Intel (x86_64)"
    AGENT_URL="$AGENT_X64_URL"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

# Download and unzip
echo "Downloading MeshAgent from: $AGENT_URL"
curl -L -o meshagent.zip "$AGENT_URL"
unzip -o meshagent.zip
chmod +x meshagent

# Run the agent
echo "Connecting MeshAgent..."
sudo ./meshagent -connect

# Install as service
echo "Installing MeshAgent as launch daemon..."
sudo ./meshagent -install

echo "✅ MeshAgent setup complete."
