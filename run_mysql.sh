#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    if [ ! -f /usr/share/mysql/my-default.cnf ] ; then
        cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf
    fi
    mysqld --initialize-insecure > /dev/null 2>&1
    echo "=> Done!"

    echo "=> Setting root password ..."
    /opt/mysql/set_root_password.sh
else
    echo "=> Using an existing volume of MySQL"
fi

exec mysqld_safe
