#!/bin/bash

if [ -x "$(command -v apt-get)" ];
then
	pm='apt-get'
elif [ -x "$(command -v yum)" ];
then
	pm='yum'
else
	echo "Error:package manager not found."

	exit 1
fi

if [ $pm=='apt-get' ];
then
	sudo $pm update
	sudo $pm install nginx -y
elif [ $pm=='yum' ];
then
	sudo $pm install epel-release -y
	sudo $pm install nginx -y
fi

if [ -x "$(command -v systemctl)" ];
then
	sm='systemctl'
elif [ -x "$(command -v service)" ];
then
	sm='service'
else
	echo "Error: service manager not found"
	exit 1
fi

if [ $sm=='systemctl' ];
then
	sudo $sm start nginx
	sudo $sm enable nginx
elif [ $sm=='service' ];
then

	sudo $sm nginx start
	sudo chkconfig nginx on
fi

sudo $sm status nginx

