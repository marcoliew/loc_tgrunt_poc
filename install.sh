cd /tmp
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.86.2/terragrunt_linux_amd64
chmod +x terragrunt_linux_amd64
sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
terragrunt --version