#!/usr/bin/env bash

echo "Provisioning guest VM..."

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y --no-install-recommends --fix-missing \
  curl \
  git \
  iproute2 \
  net-tools \
  python3 \
  python3-pip \
  tcpdump \
  unzip \
  vim \
  wget \
  xauth \
  xterm

# ---- Install Python utils ----
sudo pip3 install scapy ipaddr psutil grpcio

# ----- Mininet -----
echo "Installing Mininet"
git clone https://github.com/mininet/mininet.git
cd mininet
# Install Mininet itself (-n), the OpenFlow reference controller (-f),
# and Open vSwitch (-v)
PYTHON=python3
sudo util/install.sh -fnv

# ----- P4 tools -----
cd ~
# Add repository with P4 packages
# https://build.opensuse.org/project/show/home:p4lang

echo "deb http://download.opensuse.org/repositories/home:/p4lang/xUbuntu_20.04/ /" | sudo tee /etc/apt/sources.list.d/home:p4lang.list
wget -qO - "http://download.opensuse.org/repositories/home:/p4lang/xUbuntu_20.04/Release.key" | sudo apt-key add -

sudo apt-get update

sudo apt-get install -q -y --no-install-recommends --fix-missing \
  p4lang-p4c \
  p4lang-bmv2 \
  p4lang-pi

# ---- Setup folder lab ----
cd ~
git clone https://github.com/elavinal/sdn-p4-lab.git

echo "**** DONE PROVISIONING VM ****"

sudo reboot

