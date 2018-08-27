#!/bin/bash
# This script is meant to be run in the User Data of each EC2 Instance while it's booting. The script uses the
# run-consul script to configure and start Consul in client mode. Note that this script assumes it's running in an AMI
# built from the Packer template in examples/consul-ami/consul.json.

set -e

# Send the log output from this script to user-data.log, syslog, and the console
# From: https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Set up yum proxy
sed -e "2iproxy=http://${proxy_ip}:8888" -i /etc/yum.conf

# Bring up production interface
cat <<EOF > /etc/sysconfig/network-scripts/ifcfg-eth1
BOOTPROTO=dhcp
DEVICE=eth1
ONBOOT=yes
TYPE=Ethernet
USERCTL=no
EOF

ifup eth1
