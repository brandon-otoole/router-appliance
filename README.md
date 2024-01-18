

## Install Debian Linux
I suggest debian server and choose no graphical environment

when you do this, you will need to install and configure sudo manually

```
CURRENT_USER=$(logname)

# setup sudo
su -c apt install sudo
su -c "/sbin/usermod -aG sudo $CURRENT_USER" root
```

now you must log out and back in for the group assignment to take effect.


## Automated install

If you would like to skip the step-by-step, you can just run the setup script
```
sudo chmod +x router-setup.sh
sudo ./router-setup.sh
```

## dhclient and ifupdown
I have decided to use systemd-networkd for this router-appliance. For that
reason, we will need to remove dhclient and ifupdown

```
sudo apt purge isc-dhcp-client ifupdown
sudo rm -r /etc/network/*
sudo rm -R /etc/dhcp/dhclient*
```
