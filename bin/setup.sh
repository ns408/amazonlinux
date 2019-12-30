#!/usr/bin/env bash
# Tested on Ubuntu 18.04 LTS
set -e

#if [[ $EUID -eq 0 ]]; then
#   echo -e "This script needs to run as a non-root user with sudo privileges\n"
#   exit 1
#fi

cd /tmp

# Install aws2
if ! (/usr/local/bin/aws2 --version >& /dev/null); then
	curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
  awscli2 --version
fi

GET_TAG=$(curl --silent "https://api.github.com/repos/Versent/saml2aws/releases/latest" \
  | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
CURRENT_VERSION=$(echo "${GET_TAG//v}")
echo $CURRENT_VERSION
wget "https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz"
#wget "https://github.com/Versent/saml2aws/releases/download/v${CURRENT_VERSION}/saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz"

tar xzf saml2aws_${CURRENT_VERSION}_linux_amd64.tar.gz -C /usr/local/bin
chmod u+x /usr/local/bin/saml2aws
if (/usr/local/bin/saml2aws --version); then
  rm -rf /tmp/saml2aws*
fi