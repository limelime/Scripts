#!/bin/bash

#########################################################
# Author: Xuan Ngo
# Description: Backup your mysql database and website.
# Usage:
#	sh backup_server.sh ${DOMAIN} ${WWW_ROOT} ${BACKUP_ROOT_PATH} ${MYSQL_HOST} ${MYSQL_USER} ${MYSQL_PWD} ${MYSQL_DBNAME}
#		${DOMAIN}: Name of your website or name of your backup.
#		${WWW_ROOT}: Location of your website.
#		${BACKUP_ROOT_PATH}: Location to put your backup.
#		${MYSQL_HOST}: MySQL host.
#		${MYSQL_USER}: MySQL username.
#		${MYSQL_PWD}: MySQL password.
#		${MYSQL_DBNAME}: MySQL database name.
#
# Output:
#	- Created Folder: ${BACKUP_ROOT_PATH}/${DOMAIN}_YYYY-MM-DD_HH.MM.SS/
#	- Website files : ${BACKUP_ROOT_PATH}/${DOMAIN}_YYYY-MM-DD_HH.MM.SS/${DOMAIN}_YYYY-MM-DD_HH.MM.SS.tar.bz2
#	- SQL database  : ${BACKUP_ROOT_PATH}/${DOMAIN}_YYYY-MM-DD_HH.MM.SS/${DOMAIN}_YYYY-MM-DD_HH.MM.SS.sql.tar.bz2
#########################################################
DOMAIN_NAME=$1
WWW_ROOT=$2
BACKUP_ROOT_PATH=$3
MYSQL_HOST=$4
MYSQL_USER=$5
MYSQL_PWD=$6
MYSQL_DBNAME=$7

BACKUP_DIR_NAME=${DOMAIN_NAME}_`date +"%Y-%m-%d_%0k.%M.%S"`
BACKUP_DIR_PATH=${BACKUP_ROOT_PATH}/${BACKUP_DIR_NAME}

# Create backup directory
mkdir -p ${BACKUP_DIR_PATH}

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
T="$(date +%s)"

# Backup databases
mysqldump --hex-blob --extended-insert=false --complete-insert=true -u ${MYSQL_USER} -p${MYSQL_PWD} -h ${MYSQL_HOST} ${MYSQL_DBNAME} > ${MYSQL_DBNAME}.sql
tar -cjf ${BACKUP_DIR_PATH}/${BACKUP_DIR_NAME}.sql.tar.bz2 ${MYSQL_DBNAME}.sql
rm -f ${MYSQL_DBNAME}.sql

# Backup website
cd ${WWW_ROOT}
tar -cjf ${BACKUP_DIR_PATH}/${BACKUP_DIR_NAME}.tar.bz2 .
cd -

# Get total elapsed time
T="$(($(date +%s)-T))"
printf "${DOMAIN_NAME}: Backup elapsed time: %02d:%02d:%02d:%02d [DD:HH:MM:SS]\n" "$((T/86400))" "$((T/3600%24))" "$((T/60%60))" "$((T%60))" > ${BACKUP_DIR_PATH}/${BACKUP_DIR_NAME}.info.txt
