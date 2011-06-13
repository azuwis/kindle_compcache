#!/bin/sh
mntroot rw
cp /mnt/us/compcache/compcache.init /etc/init.d/compcache
chmod 755 /etc/init.d/compcache
ln -s /etc/init.d/compcache /etc/rc5.d/S97compcache
mntroot ro
