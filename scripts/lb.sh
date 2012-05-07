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
assert_package keepalived
assert_package apache2
assert_package haproxy
assert_package mutt
assert_package exim4
assert_package socat

assert_package php5
assert_package libapache2-mod-php5

ip=$(ip addr | grep eth1 | grep inet | awk '{print $2}' | sed 's/\/24//g');

cp -v /vagrant/files/etc/hosts /etc/hosts
cp -v /vagrant/files/root/.bashrc /root/.bashrc
cp -v /vagrant/files/etc/haproxy/haproxy.cfg /etc/haproxy/
sed -i "s/0.0.0.0/${ip}/g" /etc/haproxy/haproxy.cfg
cp -v /vagrant/files/etc/keepalived/keepalived.conf /etc/keepalived/
cp -v /vagrant/files/etc/apache2/ports.conf /etc/apache2/
cp -v /vagrant/files/etc/apache2/sites-available/example.com.conf /etc/apache2/sites-available/

a2ensite example.com.conf

sudo sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/haproxy

/etc/init.d/keepalived restart;
/etc/init.d/apache2 restart;
/etc/init.d/haproxy restart;

# gluster
assert_package libibverbs1
assert_package libibverbs-dev

if ! dpkg -l | grep -q "glusterfs" > /dev/null; then
    wget -q http://download.gluster.com/pub/gluster/glusterfs/3.2/3.2.6/Debian/5.0.3/glusterfs_3.2.6-1_amd64.deb
    dpkg -i glusterfs_3.2.6-1_amd64.deb
    modprobe fuse
    dmesg | grep -i fuse
fi;

iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 24007:24008 -j ACCEPT
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 24009:24014 -j ACCEPT


mkdir -p /mnt/test;
mount -t glusterfs file1:/test-volume /mnt/test
