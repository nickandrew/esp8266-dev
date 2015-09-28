#!/bin/bash
#
#  Start the VPN and VNC processes in this container.

cd /root

# Cleanup, if restarting a container
rm -f /tmp/.X1-lock

if grep -q '^user:' /etc/passwd ; then
	if [ ! -d /home/user ] ; then
		mkdir -p /home/user
		chown user:user /home/user
	fi
fi

if [ -n "$HOSTNAME" ] ; then
	hostname $HOSTNAME
fi

# Add host route to connect to pulse server
if [ -n "$PULSE_SERVER" ] ; then
	# Obtain it from current default route
	ip route add $PULSE_SERVER $(ip route show | grep '^default' | sed -e 's/^default //')
fi

bin/set-password.sh

/bin/su -c 'vnc4server :1' user
