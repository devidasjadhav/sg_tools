#!/bin/bash
for i in `~/sg_tools/free.sh $1 |grep mapped | awk '{printf "%d,%d\n", $2,$4}'`
  do
    a=$(echo $i | cut -d',' -f1)
    b=$(echo $i | cut -d',' -f2)
    c=$(($a+$b))
    echo $c $a $b
    for j in `seq $a 8192 $c` 
      do sg_unmap -l $j -n 8192 $1 
    done
  done
