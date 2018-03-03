#!/bin/bash

set -E

arduino=$(dirname $0)
root=$1

echo "Running chroot $root < ${arduino}/chroot.sh"
chroot $root < ${arduino}/chroot.sh

echo "rsync-ing ${arduino}/root/ to $root"
rsync -av ${arduino}/root/ $root

echo "Unpacking Learn into $root/etc/skel/Desktop ..."
mkdir -p $root/etc/skel/Desktop
tar -C $root/etc/skel/Desktop -vxf ${arduino}/Learn.tar.gz
