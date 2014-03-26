#install mysql

if [ -e /etc/init.d/mysqld ]; then
    echo "mysql already installed, skipping"
else
    CURRENT_DIRECTORY=`pwd`

    cd "$(dirname "$0")"

    check_exists DB_ADMIN
    check_exists DB_ADMIN_PASSWORD


    echo "installing mysql"
    yum -y install mysql-server mysql php-mysql
    chkconfig --levels 235 mysqld on
    service mysqld start

    echo "configuring DB_ADMIN on mysql. ignoring errors by adding || true for each line"

    mysql -u $DB_ADMIN -e "SET PASSWORD FOR '$DB_ADMIN'@'localhost' = PASSWORD('$DB_ADMIN_PASSWORD');" || true
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD -e "SET PASSWORD FOR '$DB_ADMIN'@'127.0.0.1' = PASSWORD('$DB_ADMIN_PASSWORD');" || true
    mysql -u $DB_ADMIN -e "SET PASSWORD FOR '$DB_ADMIN'@'127.0.0.1' = PASSWORD('$DB_ADMIN_PASSWORD');" || true
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD -e "SET PASSWORD FOR '$DB_ADMIN'@'localhost.localdomain' = PASSWORD('$DB_ADMIN_PASSWORD');" || true
    mysql -u $DB_ADMIN -e "SET PASSWORD FOR '$DB_ADMIN'@'localhost.localdomain' = PASSWORD('$DB_ADMIN_PASSWORD');" || true
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD -e "DROP USER ''@'localhost';" || true
    mysql -u $DB_ADMIN -e "DROP USER ''@'localhost';" || true
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD  -e  "DROP USER ''@'localhost.localdomain';" || true
    mysql -u $DB_ADMIN -e "DROP USER ''@'localhost.localdomain';" || true



    cd $CURRENT_DIRECTORY
fi

