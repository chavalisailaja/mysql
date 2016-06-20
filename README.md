# mysql

`mysql` service contains armadized MySQL server accompanied with [phpMyAdmin](http://www.phpmyadmin.net) interface
configured to access it.

:warning: Due to apparmor policy issue MySQL container will not initialize on a host with MySQL server installed. [Related Issue](https://github.com/docker/docker/issues/7512)
# Building and running the service.

    armada build mysql
    armada run mysql -v /var/opt/mysql-storage:/var/lib/mysql -p 3306:3306

MySQL database data is stored in directory `/var/lib/mysql` inside the container. To ensure its persistence
it should be mapped to some folder on the host machine, e.g. `/var/opt/mysql-storage`.

MySQL server binds to port 3306 and is exposed as main service's port.
PhpMyAdmin is exposed on separate port and visible in Armada catalog as `mysql:phpmyadmin`.
In the above example we've mapped port 3306 to the same port on the host machine, but you can also use other service
discovery methods to connect to it.


# Initializing the database.

When you run `mysql` service with empty directory mapped to `/var/lib/mysql`, new MySQL database will be initialized.
There will be one MySQL user created: `root` with password `groovy`. If you want to alter the password you can set
it with environment variable like this:

    armada run mysql -v /var/opt/mysql-storage:/var/lib/mysql -e "MYSQL_ROOT_PASSWORD=secret!"


