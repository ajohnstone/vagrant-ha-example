#!/bin/bash

DEBIAN_FRONTEND=noninteractive

sudo sysctl -q -w net.ipv4.ip_nonlocal_bind=1
sudo sysctl -q -w net.ipv4.conf.all.forwarding=1

INSTALLER_LOG=/var/log/non-interactive-installer.log
 
installnoninteractive(){
    sudo bash -c "DEBIAN_FRONTEND=noninteractive aptitude install -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'  -f -q -y $* >> $INSTALLER_LOG"
}
 
assert_package() {
    is_installed=$(apt-cache policy "$1" | grep 'Installed: (none)' | wc -l);
    if [ "$is_installed" -eq "1" ] ; then
        #apt-get install -q -y $1;
        installnoninteractive $1;
    fi;
}

apt-get update > /dev/null;
assert_package lvm2
#assert_package glusterfs-server
assert_package mutt
assert_package exim4
assert_package socat

ip=$(ip addr | grep eth1 | grep inet | awk '{print $2}' | sed 's/\/24//g');

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 24007:24047 -j ACCEPT 
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 111 -j ACCEPT 
iptables -A INPUT -m state --state NEW -m udp -p udp --dport 111 -j ACCEPT 
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 38465:38467 -j ACCEPT

cp -v /vagrant/files/etc/hosts /etc/hosts
cp -v /vagrant/files/root/.bashrc /root/.bashrc

wget -q http://download.gluster.com/pub/gluster/glusterfs/LATEST/Debian/5.0.3/glusterfs_3.2.6-1_amd64.deb
assert_package openssh-server
assert_package wget
assert_package nfs-common
assert_package libibverbs-dev
assert_package libibverbs1
dpkg -i glusterfs_3.2.6-1_amd64.deb

update-rc.d glusterd defaults
 /etc/init.d/glusterd start

if [ "$ip" == "10.20.10.6" ]; then

    if ! gluster peer status | grep -q "file1" > /dev/null; then
        gluster peer probe file1
    fi;
    if ! gluster volume info | grep -q "test-volume" > /dev/null; then
        gluster volume create test-volume file1:/exp3 file2:/exp4

        gluster volume set test-volume auth.allow 10.*
        gluster volume start test-volume
    fi;
fi;
