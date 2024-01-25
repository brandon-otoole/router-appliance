
# Setup Bundle

A convenient setup bundle can be created with just a few docker commands. You
can use the compose.yaml file in this folder, or you can use a single docker
command.

```
docker run -v ./config:/input -v ./dist:/output router-builder
```

# Required files
The following files are required to make the router function. Please see the
example folder for bare minimum examples of each file.

```
config/
|-- dhcp/
|    |-- dhcpd.conf
|    |-- isc-dhcp-server
|
|-- firewall-rules/
|    |-- iptables
|    |-- ip6tables
|
|-- networkd/
|    |-- 00-vlan-[VLAN-ID].netdev
|    |-- 10-adapter-[DEVICE].network
|    |-- 20-vint-[VLAN-ID].network
|
|-- scripts/
|    |-- router-firewall-network.target
|    |-- router-firewall-setup.service
|    |-- router-firewall-update.sh
|
|-- sysctl/
|    |-- 50-router.conf
```
