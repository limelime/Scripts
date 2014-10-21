#!/bin/bash

DOMAIN="openwritings.net"
BACKUP_ROOT_PATH=${HOME}/backup

sh /home1/openwrit/scripts/backup/del_old_backup.sh ${DOMAIN} ${BACKUP_ROOT_PATH}