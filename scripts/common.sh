#!/bin/bash

DEBIAN_FRONTEND=noninteractive

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
