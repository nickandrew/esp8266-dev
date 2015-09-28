#!/bin/bash

if [ ! -f /home/user/.vnc/passwd ] ; then
	echo "Set a password now"
	/bin/su -c vncpasswd user
fi
