#!/usr/bin/env bash

# Determine architecture
ARCH=$(uname -m)
if [ "$ARCH" = "x86_64" ]; then
    ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

sudo apt update
 
# nodejs
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

#curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Get the latest release version from GitHub
VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | jq -r .tag_name)
if [ -z "$VERSION" ]; then
    echo "Failed to get the latest version."
else
    # Download the latest release
    curl -sSL -o lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${VERSION}/lazygit_${VERSION#v}_linux_${ARCH}.tar.gz"

    # Extract and install
    tar xzf lazygit.tar.gz
    sudo mv lazygit /usr/local/bin/lazygit

    # Clean up
    rm lazygit.tar.gz

fi
# kubectl
# Download kubectl
KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl"

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# Clean up
rm kubectl

# Download argocd
curl -sSL -o /usr/local/bin/argocd "https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-${ARCH}"

# Install argocd
sudo chmod +x /usr/local/bin/argocd

sudo apt install -y curl git wget build-essential software-properties-common fd-find ripgrep fzf gh jq yq kubectx tmux

if [ "$ARCH" = "x86_64" ]; then
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim
    sudo chmod +x /usr/local/bin/nvim
else
    sudo apt install -y neovim
fi

