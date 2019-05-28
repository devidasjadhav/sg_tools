#!/bin/bash
cnt=0
while true
do
 out=`sg_get_lba_status $1 -l $cnt 2>&1 > /dev/null`
 if [ $? != "0" ]
 then
  break
 fi

 sz=`sg_get_lba_status $1 -l $cnt |cut -d':' -f 3 |awk '{print $1}'`
 st=`sg_get_lba_status $1 -l $cnt |cut -d':' -f 3 |awk '{print $2}'`

 if [ $st == "mapped" ]
 then
  echo "Unmaping" $cnt $sz $st
  sg_unmap --lba=$cnt --num=$sz $1
 fi
 #upadating count
 cnt=$(( $cnt + $sz ))
done
