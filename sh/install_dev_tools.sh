#! /bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
packages=(docker-ce docker-compose-plugin python3 python3-pip python3-django)

if [ $(id -u) -ne 0 ]
  then echo -e "${RED}Please run this script as root or using sudo!${NC}"
  exit
fi

echo -e "${GREEN}Initializing ...${NC}"
apt-get update -qq

if [ $(dpkg-query -W -f='${Status}' ca-certificates 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    apt-get install ca-certificates -y -qq
fi

if [ $(dpkg-query -W -f='${Status}' curl 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
    apt-get install curl -y -qq
fi

install -m 0755 -d /etc/apt/keyrings > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc > /dev/null
chmod a+r /etc/apt/keyrings/docker.asc > /dev/null

# Add the repository to Apt sources:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -qq

for packageName in "${packages[@]}"; do
    echo -e "${GREEN}Checking $packageName ${NC}"
    if [ $(dpkg-query -W -f='${Status}' $packageName 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo -e "${GREEN}Installing $packageName ${NC}"
        apt-get install $packageName -y
    else
        echo -e "${GREEN}$packageName is already installed ${NC}"
    fi
done
