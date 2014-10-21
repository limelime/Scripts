#!/bin/bash

#########################################################
# Author: Xuan Ngo
# Description: Delete backup folders that are 2 months old.
# Usage:
#	sh del_old_backup.sh ${DOMAIN} ${BACKUP_ROOT_PATH}
#		${DOMAIN}: Name of your website or name of your backup.
#		${BACKUP_ROOT_PATH}: Location to put your backup.
#########################################################
DOMAIN_NAME=$1
BACKUP_ROOT_PATH=$2

LAST_2_MONTHS="$(date --date='2 month ago' +%Y-%m-%d)"
DELETE_DIR=${BACKUP_ROOT_PATH}/${DOMAIN_NAME}_${LAST_2_MONTHS}*
rm -rf ${DELETE_DIR}
