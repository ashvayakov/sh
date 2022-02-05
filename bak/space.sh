#!/bin/sh
# space.sh 

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"

LOG="/export/home/billpro/logs/${USERX}.log"
GRP="clients"

coma=0

echo "["
for USERX in $(grep ^cb[0-9] /etc/passwd | cut -d ":" -f1)
do
	BNAME=$( grep ^${USERX} /etc/passwd | cut -d ":" -f6)
	ZUSED="$(zfs get -Hp used ${BNAME} | awk '{print $3}')"
	ZQUOTA="$(zfs get -Hp quota ${BNAME} | awk '{print $3}')"
	ZAVAIL="$(zfs get -Hp available ${BNAME}| awk '{print $3}')"
if [ $coma == 0 ]
then
  coma=1
else
  echo ','
fi

echo "{" 
echo "\"userid\":\"$USERX\"," 
echo "\"folder\":\"${BNAME}\"," 
echo "\"quota\":${ZQUOTA}," 
echo "\"used\":${ZUSED}," 
echo "\"available\":${ZAVAIL}" 
echo "}" 

done
echo "]"


