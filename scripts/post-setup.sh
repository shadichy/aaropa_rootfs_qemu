#!/bin/bash

for d in \
  android \
  boot/grub \
  boot/efi \
  cdrom \
  root \
  source; do
  mkdir -p $d
done

# setup autologin
sed -i 's@1:2345:respawn:/sbin/getty@1:2345:respawn:/sbin/getty -n -l /usr/sbin/autologin@g' /etc/inittab
# change default shell to bash
sed -i -r 's|^(root:.*:)/bin/d?a?sh$|\1/bin/bash|g' /etc/passwd

busybox --install -s /bin

# Additional setup
ln -s pcmanfm-qt /usr/bin/pcmanfm

# Enable dbus and udev services
update-rc.d dbus defaults
update-rc.d udev defaults
update-rc.d eudev defaults

# Remove debian-specific boot configurations
rm -f /etc/grub.d/*debian*

exit 0
