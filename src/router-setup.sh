#!/bin/bash

# require sudo
if [ "$EUID" -ne 0 ]; then
    echo "This script must be called with sudo."
    exit 1
fi

# remove old dhcp client and network config
apt purge isc-dhcp-client ifupdown
rm -r /etc/network/*
rm -r /etc/dhcp/dhclient*

# install required packages
apt install iptables radvd

# enable forwarding
cp ./config/sysctl/50-router.conf /etc/sysctl.d/50-router.conf

###################
# setup the vlans #
###################

# copy the networkd configuration files
cp ./config/networkd/* /etc/systemd/network/

######################
# setup the firewall #
######################

# copy the user firewall rules
cp .config/firewall-rules/iptables /etc/network/
cp .config/firewall-rules/ip6tables /etc/network/

# copy the iptables update script
cp ./config/scripts/router-firewall-update.sh \
    /usr/local/sbin/router-firewall-update.sh

# copy the firewall setup target and service files
cp ./config/scripts/router-firewall-network.target \
    /etc/systemd/system/router-firewall-network.target
cp ./config/scripts/router-firewall-setup.service \
    /etc/systemd/system/router-firewall-setup.service

# register the new service and target files
systemctl daemon-reload

# enable the service and target files
systemctl enable router-firewall-network.target
systemctl enable router-firewall-setup.service

# run the iptables update script
/usr/local/sbin/router-firewall-update.sh

# switch to using systemd-networkd
systemctl enable systemd-networkd
systemctl restart systemd-networkd

##############
# setup dhcp #
##############

apt install isc-dhcp-server

# copy the user config files
cp ./config/dhcp/isc-dhcp-server /etc/default/isc-dhcp-server
cp ./config/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf

# enable and restart the dhcp server
systemctl enable isc-dhcp-server
systemctl restart isc-dhcp-server.service
