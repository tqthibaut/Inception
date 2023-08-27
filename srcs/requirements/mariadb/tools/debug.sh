#!/bin/bash
whoami

echo "$USER"

if [ -d /var/lib/mysql/wordpress ]; then
	echo "Database Wordpress exists !!!"
fi

ls -lar var
ls -laR var/lib/mysql

exec "tail -f /dev/null"
