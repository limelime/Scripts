#!/bin/bash
# Description: Copy apt cache archive directory to another directory.
# Requirements: aptitude -y install dpkg-dev
# Make this script run at shutdown:
# $ chmod +x keep-apt-cache.sh
# $ cp keep-apt-cache.sh /etc/init.d/
# $ cd /etc/init.d/
# $ update-rc.d keep-apt-cache.sh start 20 0 6 .
# http://www.linuxquestions.org/questions/debian-26/run-this-command-when-the-computer-shutdown-or-reboot-683851/
# https://help.ubuntu.com/community/Repositories/Personal

DEB_VERSION="$(lsb_release -si)-$(lsb_release -sr)-$(lsb_release -sc)"
DEST_BASEDIR=/media/sf_shared/debian-apt-cache
SRC_APT_CACHE_ARCHIVES_DIR=/var/cache/apt/archives

### Find out what is the architecture.
ARCH="32bit"
if echo `uname -m` | grep "x86_64" 
then
  ARCH="64bit"
fi

### Copy *.deb packages to destination directory.
DEST_APT_CACHE_ARCHIVES_DIR=${DEST_BASEDIR}/"${DEB_VERSION}-${ARCH}"
mkdir -p ${DEST_APT_CACHE_ARCHIVES_DIR}
rsync -a "${SRC_APT_CACHE_ARCHIVES_DIR}/" "${DEST_APT_CACHE_ARCHIVES_DIR}"
echo "Copied ${SRC_APT_CACHE_ARCHIVES_DIR} to ${DEST_APT_CACHE_ARCHIVES_DIR}."


### Generate package list to be used as repository.
cd "${DEST_APT_CACHE_ARCHIVES_DIR}"
dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz



### References
# https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories-on-a-vps