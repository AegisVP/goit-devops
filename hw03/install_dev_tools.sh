#! /bin/bash

packages=(docker-ce python3 python3-pip python3-django)

if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

echo "Initializing ..."
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
    echo "Checking $packageName"
    if [ $(dpkg-query -W -f='${Status}' $packageName 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo "Installing $packageName"
        apt-get install $packageName -y
    else
        echo "$packageName is already installed"
    fi
done
