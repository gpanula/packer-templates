#!/bin/bash
set -x

# Install required tools to work with qcow2 images
sudo yum install -y qemu-img nano wget

# Get the image
wget https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-ec2-8.1.1911-20200113.3.x86_64.qcow2

# unpack it into nvme1n1, this is not very dynamic at the moment
sudo qemu-img convert -f qcow2 -O raw CentOS-8-ec2-8.1.1911-20200113.3.x86_64.qcow2 /dev/nvme1n1

# Mount the new FS without UUID since it can conflict with the local UUID
sudo mount -o nouuid /dev/nvme1n1p1 /mnt/
# bind system (pseudo-)filesystems for chroot later
sudo mount -o bind /proc /mnt/proc
sudo mount -o bind /dev /mnt/dev
sudo mount -o bind /sys /mnt/sys

# un-enforce selinux so we can ssh in later
sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /mnt/etc/selinux/config

# copy resolver config so we can run dnf later
sudo cp /etc/resolv.conf /mnt/etc/resolv.conf

# bootloader specification doesn't play nice with aws
sudo sed -i 's/GRUB_ENABLE_BLSCFG=true/GRUB_ENABLE_BLSCFG=false/g' /mnt/etc/default/grub

# tell dnf to update, this also updates grub and rewrites the config
sudo chroot /mnt dnf upgrade -y

# unmount everything we are done
sudo umount /mnt/dev
sudo umount /mnt/proc
sudo umount /mnt/sys
sudo umount /mnt

# ensure the caches are all flushed to disk
sudo sync
sudo sync
sudo sync
# we are done