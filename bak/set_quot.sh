#!/bin/sh
# set_quot.sh <product ID> <quota GB>

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"

USERX="cb${1}"
QUOTAX=$2
MDATE="$(date +%Y-%m-%d-%H:%M)"
LOG="/export/home/billpro/logs/${USERX}.log"
GRP="clients"
BNAME="DEPOT/$GRP"

[ -f $LOG ] || echo "-------------------------------------------------" > $LOG
echo "\n$MDATE" >> $LOG

sudo zfs set quota=${QUOTAX}G ${BNAME}/${USERX} 2>&1 | tee -a $LOG
zfs get quota,used,available ${BNAME}/${USERX}  2>&1 >> $LOG


echo "{" | tee -a $LOG
echo "\"userid\":\"$USERX\"," | tee -a $LOG
echo "\"quota\":\"$QUOTAX\"" | tee -a $LOG
echo "}" | tee -a $LOG
echo "-------------------------------------------------" >> $LOG


