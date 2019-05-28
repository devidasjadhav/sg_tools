#!/bin/bash
cnt=0
echo "--------------------------------------------------------------"
echo "|             Count   |         size        |       state    |"
echo "--------------------------------------------------------------"
while true
do
 out=`sg_get_lba_status $1 -l $cnt 2>&1 `
 if [ $? != "0" ]
 then
  echo "--------------------------------------------------------------"
  break
 fi
 sz=`echo $out |cut -d':' -f 3 |awk '{print $1}'`
 st=`echo $out |cut -d':' -f 3 |awk '{print $2}'`
# echo "$cnt $sz $st"
 printf "|%20ld |%20ld |  %12s  |\n" $cnt $sz $st
 cnt=$(( $cnt + $sz ))
done
