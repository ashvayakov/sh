#!/bin/sh
# set_pass.sh <product ID> <Password>

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"
USERX="cb${1}"
PASSX=${2}
MDATE="$(date +%Y-%m-%d-%H:%M)"
LOG="/export/home/billpro/logs/${USERX}.log"

[ -f $LOG ] || echo "-------------------------------------------------" > $LOG
echo "\n$MDATE" >> $LOG

/etc/scripts/billing/chpass.sh ${USERX} ${PASSX} 2>&1 >> $LOG 

echo "{" | tee -a $LOG
echo "\"userid\":\"$USERX\"," | tee -a $LOG
echo "\"pass\":\"$PASSX\"" | tee -a $LOG
echo "}" | tee -a $LOG
echo "-------------------------------------------------" >> $LOG



