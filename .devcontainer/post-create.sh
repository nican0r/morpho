#!/bin/bash
set -e

# Install dependencies for Echidna
echo "Installing dependencies for Echidna..."
sudo apt-get update
sudo apt-get install -y libreadline-dev libsecp256k1-dev

# Install solc-select (for Solidity compiler management)
pip install solc-select
solc-select install 0.8.28
solc-select use 0.8.28

# Install Slither (Echidna dependency)
pip install slither-analyzer

# Install Echidna via Homebrew (Linuxbrew for Ubuntu)
echo "Installing Echidna..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/vscode/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install echidna

# Install Foundry
echo "Installing Foundry..."
curl -L https://foundry.paradigm.xyz | bash
/home/vscode/.foundry/bin/foundryup

# Install Claude Code CLI (requires Claude account credentials)
echo "Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code
echo "Claude Code CLI installed. Please run 'claude-code login' to authenticate."

# Verify installations
echo "Verifying installations..."
echidna --version
forge --version
cast --version
anvil --version
chisel --version
claude-code --version