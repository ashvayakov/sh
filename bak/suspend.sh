#!/bin/sh
# suspend.sh <product ID> <1.2.3.4,1.2.3.5>

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"
PASSX="$(openssl rand -base64 9)"
USERX="cb${1}"
MDATE="$(date +%Y-%m-%d-%H:%M)"
LOG="/export/home/billpro/logs/${USERX}.log"
GRP="clients"
BNAME="DEPOT/$GRP"

[ -f $LOG ] || echo "-------------------------------------------------" > $LOG
echo "\n$MDATE" >> $LOG
/etc/scripts/billing/chpass.sh ${USERX} ${PASSX} 2>&1 >> $LOG
sudo zfs set sharenfs=off ${BNAME}/${USERX} 2>&1 >> $LOG

for IPF in $(echo $2 | sed -e s/\,/\ /g) 
do
sudo ippool -r -m 500 -i ${IPF} > /dev/null 2>&1
done    


