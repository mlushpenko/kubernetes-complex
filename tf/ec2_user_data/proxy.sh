#!/bin/bash
# This script is meant to be run in the User Data of each EC2 Instance while it's booting. The script uses the
# run-consul script to configure and start Consul in client mode. Note that this script assumes it's running in an AMI
# built from the Packer template in examples/consul-ami/consul.json.

set -e

# Send the log output from this script to user-data.log, syslog, and the console
# From: https://alestic.com/2010/12/ec2-user-data-output/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Install ansible, git and python-pip
apt-get update -y
apt-get install -y software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update -y
apt-get install -y ansible python-pip git
ansible --version
export LC_ALL=C
pip list

# Install tiny-proxy
apt-get install -y tinyproxy
sed -i 's/Allow 127.0.0.1/Allow 0.0.0.0\/0/g' /etc/tinyproxy.conf
systemctl restart tinyproxy.service
systemctl enable tinyproxy.service

# Get kubernetes
git clone https://github.com/mlushpenko/kubespray-test.git /home/ubuntu/kubespray
chown -R ubuntu: /home/ubuntu/kubespray
exec sudo -u ubuntu /bin/sh - << eof
pip install --user -r /home/ubuntu/kubespray/requirements.txt
eof

