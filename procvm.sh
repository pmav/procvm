#!/bin/bash

# procvm.sh (v0.1)
# https://github.com/pmav/procvm
#
# http://pmav.eu

for process in `ls -m /proc/ | cut --delimiter=',' --fields=1- | grep '^[0-9]' | tr -d ','`; do

       if [ -f /proc/$process/status ]; then

               vmsize=`cat /proc/$process/status | grep VmSize`
               
               if [ `expr length "$vmsize"` -gt 0 ]; then

			           name=`cat /proc/$process/status | grep Name`
                       name=${name/Name:}
                       name=`echo $name | tr -s " "`
               
                       vmsize=${vmsize/VmSize:}
                       vmsize=${vmsize/kB}
                       vmsize=`echo $vmsize | tr -s " "`
                       vmsize=`echo "scale=0; $vmsize / 1024" | bc`

                       processpath=`ps -p $process -o args --no-heading | nawk '{print substr($0,1,120)}' | awk '{gsub(/^ +| +$/,"")}1'`

                       echo -e "$process\t$vmsize MB\t\t`tput setaf 2`$name`tput op` ($processpath)"
               fi
       fi
done

tput op