#install mysql

if [ -e /etc/init.d/mysqld ]; then
    echo "mysql already installed, skipping"
else
    CURRENT_DIRECTORY=`pwd`

    cd "$(dirname "$0")"

    if [ -z $DB_ADMIN ] || [ -z DB_ADMIN_PASSWORD ]; then

        echo "cannot install mysql, please define DB_ADMIN and DB_ADMIN_PASSWORD

    fi

    echo "installing mysql"
    yum -y install mysql-server mysql php-mysql
    chkconfig --levels 235 mysqld on
    service mysqld start
    mysql -u $DB_ADMIN -e "SET PASSWORD FOR '$DB_ADMIN'@'localhost' = PASSWORD('$DB_ADMIN_PASSWORD');"
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD -e "SET PASSWORD FOR '$DB_ADMIN'@'127.0.0.1' = PASSWORD('$DB_ADMIN_PASSWORD');"
    mysql -u $DB_ADMIN -e "SET PASSWORD FOR '$DB_ADMIN'@'127.0.0.1' = PASSWORD('$DB_ADMIN_PASSWORD');"
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD -e "SET PASSWORD FOR '$DB_ADMIN'@'localhost.localdomain' = PASSWORD('$DB_ADMIN_PASSWORD');"
    mysql -u $DB_ADMIN -e "SET PASSWORD FOR '$DB_ADMIN'@'localhost.localdomain' = PASSWORD('$DB_ADMIN_PASSWORD');"
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD -e "DROP USER ''@'localhost';"
    mysql -u $DB_ADMIN -e "DROP USER ''@'localhost';"
    mysql -u $DB_ADMIN -p$DB_ADMIN_PASSWORD  -e  "DROP USER ''@'localhost.localdomain';"
    mysql -u $DB_ADMIN -e "DROP USER ''@'localhost.localdomain';"


    cd $CURRENT_DIRECTORY
fi

