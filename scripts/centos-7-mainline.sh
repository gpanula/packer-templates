#!/bin/bash
set -x

# We need ElRepo for ML Kernels, and we get their signing key as well
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

# Install ML kernel
sudo yum --enablerepo=elrepo-kernel -y install kernel-ml

# Delete grubenv to un-remember the last booted kernel
sudo rm /boot/grub2/grubenv