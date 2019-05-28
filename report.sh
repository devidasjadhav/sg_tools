#!/bin/bash
humanReadable () {
  var=$(numfmt --to=iec-i --suffix=B --padding=7 $(($1 * 512)))
  echo "$var"
}
./free.sh $1 > test

m=`tail -n +4 test | head -n -1 |grep mapped |awk '{print $4}' | paste -sd+ | bc`
u=`tail -n +4 test | head -n -1 |grep -v mapped |awk '{print $4}' | paste -sd+ | bc`
d_size=$(( $m + $u ))
echo "Disk Size: $(humanReadable $d_size)"
echo "Mapped:    $(humanReadable $m)"
echo "Unmapped:  $(humanReadable $u)"
