#!/bin/bash

curl 192.168.56.102:80 &> /dev/null

if [ ! $? == 0 ] || [ ! -e /var/www/html/index.nginx-debian.html ]; then 
	exit 1;
else exit 0
fi
