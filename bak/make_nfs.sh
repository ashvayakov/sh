#!/bin/sh
# make_nfs.sh <product ID> <anon=nobody,sec=sys,rw=@185.15.186.81:@77.72.128.142,root=@185.15.186.81:@77.72.128.142> <1.2.3.4,1.2.3.5>

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"

USERX="cb${1}"
IPNFS=$2
MDATE="$(date +%Y-%m-%d-%H:%M)"
LOG="/export/home/billpro/logs/${USERX}.log"
GRP="clients"
BNAME="DEPOT/${GRP}"
IPFW=$(echo $3 | sed -e s/\,/\ /g) 
[ -f $LOG ] || echo "-------------------------------------------------" > $LOG
echo "\n$MDATE" >> $LOG

[[ ! -d /${BNAME}/${USERX}/4NFS ]] && sudo mkdir -m777 /${BNAME}/${USERX}/4NFS 2>&1  >> $LOG
sudo zfs set sharenfs=${IPNFS} ${BNAME}/${USERX} 2>&1 >> $LOG

for IPF in $(echo $3 | sed -e s/\,/\ /g) 
do
sudo ippool -a -m 500 -i ${IPF} > /dev/null 2>&1
done

echo "{" | tee -a $LOG
echo "\"userid\":\"$USERX\"," | tee -a $LOG
echo "\"folder\":\"${BNAME}/${USERX}\"," | tee -a $LOG
echo "\"access_ip\":\"${IPNFS}\"," | tee -a $LOG
echo "\"fw_ip\":\"${IPFW}\"" | tee -a $LOG
echo "}" | tee -a $LOG
echo "-------------------------------------------------" >> $LOG


