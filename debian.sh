#update to latest & install curl for variables
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y

ARCH=$(dpkg --print-architecture)
LATEST_GO=$(curl -s https://go.dev/VERSION?m=text | head -n1)

#build/dev tools
sudo apt install -y build-essential clang cmake gettext ninja-build git gdb python3 pip pipx python-is-python3 apt-transport-https ca-certificates gnupg
#cli tools
sudo apt install -y aria2 wget openssh-client nano unzip zip iperf3 btop rclone rsync fzf tealdeer tmux 7zip nnn

#custom repos
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y kubectl kubeadm helm docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#.debs
wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_${ARCH}.deb && sudo apt install ./k9s_linux_${ARCH}.deb && rm k9s_linux_${ARCH}.deb

#not in apt
wget https://go.dev/dl/${LATEST_GO}.linux-${ARCH}.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${LATEST_GO}.linux-${ARCH}.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile

curl https://sh.rustup.rs -sSf | sh -s -- -y

curl -s https://fluxcd.io/install.sh | sudo FLUX_VERSION=2.0.0 bash

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

/usr/local/go/bin/go env -w GOPATH=$HOME/.go
echo 'export PATH=$PATH:$HOME/.go/bin' >> $HOME/.profile
/usr/local/go/bin/go install sigs.k8s.io/kind@v0.25.0
/usr/local/go/bin/go install sigs.k8s.io/kustomize/kustomize/v5@latest

pipx install yt-dlp awscliv2
awsv2 --install
echo "alias aws='awsv2'" >> $HOME/.profile

#post install
tldr --update
sudo usermod -aG docker $USER

#not sure about those d:
# sudo systemctl enable docker.service
# sudo systemctl enable containerd.service

sudo mkdir -p /etc/docker
echo '{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}' | sudo tee /etc/docker/daemon.json > /dev/null
