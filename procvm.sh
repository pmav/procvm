# procvm.sh (v0.2.0)
#
# https://github.com/pmav/procvm
#
# http://pmav.eu
#
# v0.1.0 - Initial release (04/May/2011).
# v0.2.0 - VM RSS added (03/Sep/2011).

# Header
echo -e "PID\tVmRSS\tVmSize\t\tName (Path)\n"

for process in `ls -m /proc/ | cut --delimiter=',' --fields=1- | grep '^[0-9]' | tr -d ','`; do

	# For each process in the system.
	if [ -f /proc/$process/status ]; then

		process_status=`cat /proc/$process/status`

		if [[ "$process_status" =~ "VmSize:" ]]; then

			# Handle Name
			name=$(echo "$process_status" | grep 'Name')
			name=${name/Name:}
			name=`echo $name | tr -s " "`

			# Handle VmSize
			vmsize=$(echo "$process_status" | grep 'VmSize')
			vmsize=${vmsize/VmSize:}
			vmsize=${vmsize/kB}
			vmsize=`echo $vmsize | tr -s " "`
			vmsize=`echo "scale=0; $vmsize / 1024" | bc`

			# Handle VmRSS
			vmrss=$(echo "$process_status" | grep 'VmRSS')
			vmrss=${vmrss/VmRSS:}
			vmrss=${vmrss/kB}
			vmrss=`echo $vmrss | tr -s " "`
			vmrss=`echo "scale=0; $vmrss / 1024" | bc`

			processpath=`ps -p $process -o args --no-heading | nawk '{print substr($0,1,120)}' | awk '{gsub(/^ +| +$/,"")}1'`

			echo -e "$process\t$vmrss MB\t$vmsize MB\t\t`tput setaf 2`$name`tput op` ($processpath)"
		fi
       fi
done

tput op
