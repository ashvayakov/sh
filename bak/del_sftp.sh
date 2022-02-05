#!/bin/sh
USERX="cb${1}"

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"
LOG="/export/home/billpro/logs/${USERX}.log"
GRP="clients"
BNAME="DEPOT/${GRP}"

[ -f $LOG ] || echo "-------------------------------------------------">> $LOG
echo "############## $(date +%F-%T) ##############" >> $LOG
echo "-------------------------------------------------">> $LOG
	sudo zfs destroy -f ${BNAME}/${USERX} 2>&1 >> $LOG
	sudo userdel ${USERX} 2>&1 >> $LOG
echo "-------------------------------------------------" >> $LOG

