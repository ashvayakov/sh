#!/bin/sh
# make_sftp.sh <product ID> <quota GB> 

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"

USERX="cb${1}"
PASSX="$(openssl rand -base64 9)"
QUOTAX=$2
SERV_IP=$3
SPORT=$4
MDATE="$(date +%Y-%m-%d-%H:%M)"
LOG="/export/home/billpro/logs/${USERX}.log"
GRP="clients"
BNAME="DEPOT/$GRP"

[ -f $LOG ] || echo "-------------------------------------------------" > $LOG
echo "\n$MDATE" >> $LOG

sudo zfs create ${BNAME}/${USERX} 2>&1 | tee -a $LOG
sudo zfs set quota=${QUOTAX}G ${BNAME}/${USERX} 2>&1 | tee -a $LOG
sudo chown root:$GRP /${BNAME}/${USERX}
sudo chmod 755 /${BNAME}/${USERX}
sudo useradd -g $GRP -s /bin/false -d /${BNAME}/${USERX} ${USERX} 2>&1 | tee -a $LOG

sudo mkdir -m755 /${BNAME}/${USERX}/4sftp 2>&1 | tee -a $LOG
sudo chown $USERX:$GRP /${BNAME}/${USERX}/4sftp
sudo chmod 755 /${BNAME}/${USERX}/4sftp
/etc/scripts/billing/chpass.sh ${USERX} ${PASSX} 2>&1 > /dev/null



echo "{" | tee -a $LOG
echo "\"userid\":\"$USERX\"," | tee -a $LOG
echo "\"pass\":\"$PASSX\"," | tee -a $LOG
echo "\"quota\":\"$QUOTAX\"" | tee -a $LOG
echo "}" | tee -a $LOG
echo "-------------------------------------------------" >> $LOG


