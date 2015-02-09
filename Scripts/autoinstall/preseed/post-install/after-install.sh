#!/bin/sh
# Description: Create a service that will run firstboot.sh script once and on the first boot.
#				Put all your commands in firstboot.sh and not here because this script is
#				still run  under the installer and the installer’s post-install environment is pretty limiting. 
# Author: Xuan Ngo
# Reference: http://www.50ply.com/blog/2012/07/16/automating-debian-installs-with-preseed-and-puppet/
#			 https://wiki.debian.org/LSBInitScripts

POST_INSTALL_DIR=/root/post-install

# Create a service that will run our firstboot.sh script
cat > /etc/init.d/firstboot <<EOF
### BEGIN INIT INFO
# Provides:        firstboot
# Required-Start:  $networking
# Required-Stop:   $networking
# Default-Start:   2 3 4 5
# Default-Stop:    0 1 6
# Short-Description: A script that runs once
# Description: A script that runs once
### END INIT INFO

cd /${POST_INSTALL_DIR} ; /usr/bin/nohup sh -x /${POST_INSTALL_DIR}/firstboot.sh &


EOF

# Install the firstboot service
chmod +x /etc/init.d/firstboot
update-rc.d firstboot defaults