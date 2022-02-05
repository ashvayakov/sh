#!/bin/sh
# info.sh <product ID> 

PATH="/usr/gnu/bin:/usr/bin:/usr/sbin:/sbin"

USERX="cb${1}"
LOG="/export/home/billpro/logs/${USERX}.log"
GRP="clients"
BNAME="DEPOT/$GRP"

ZUSED="$(zfs get -Hp used ${BNAME}/${USERX} | awk '{print $3}')"
ZQUOTA="$(zfs get -Hp quota ${BNAME}/${USERX} | awk '{print $3}')"
ZAVAIL="$(zfs get -Hp available ${BNAME}/${USERX} | awk '{print $3}')"
ZNFS="$(zfs get -Hp  sharenfs ${BNAME}/${USERX} | awk '{print $3}')"


echo "{" 
echo "\"userid\":\"$USERX\"," 
echo "\"folder\":\"${BNAME}/${USERX}\"," 
echo "\"quota\":${ZQUOTA}," 
echo "\"used\":${ZUSED}," 
echo "\"available\":${ZAVAIL}," 
echo "\"sharenfs\":\"${ZNFS}\""
echo "}" 



