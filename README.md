# procvm
procvm is a linux shell scripts that list VM size, PID and comand for each process.

### Usage
	./procvm.sh

## Example
	1       23 MB           init (/sbin/init)
	1009    5 MB            getty (/sbin/getty -8 38400 tty2)
	10128   216 MB          apache2 (/usr/sbin/apache2 -k start)
	1013    5 MB            getty (/sbin/getty -8 38400 tty6)
	10154   216 MB          apache2 (/usr/sbin/apache2 -k start)
	1016    33 MB           avahi-daemon (avahi-daemon: chroot helper)
	10169   206 MB          apache2 (/usr/sbin/apache2 -k start)
	1019    3 MB            acpid (acpid -c /etc/acpi/events -s /var/run/acpid.socket)

### Future Features
* Filter by VM size.
* Units: KB, MB, GB, ...