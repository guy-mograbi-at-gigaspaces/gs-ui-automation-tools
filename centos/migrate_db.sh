# get all sysconf variables we have for play

CURRENT_DIR=`pwd`
echo "current dir is $CURRENT_DIR"

echo "changing workdir"
cd "$(dirname "$0")"
echo "workdir is now `pwd`"

check_exists DB_USER
check_exists DB_PASSWORD
check_exists DB
check_exists BASEDIR
check_exists UPGRADE_TO

echo "upgrading to [ $UPGRADE_TO ]"


migrate_create(){
    DB_STATUS=`mysqlshow "$DB" -u $DB_ADMIN -p$DB_ADMIN_PASSWORD > /dev/null 2>&1 || echo "missing"`
    if [ "$DB_STATUS" = "missing" ];then
        echo "creating DB"
        `mysql -u $DB_USER -p$DB_PASSWORD  -e "create database $DB"`
        if [ -e $BASEDIR/create.sql ]; then
            echo "running create file from $BASEDIR/create.sql"

            `mysql -u $DB_USER -p$DB_PASSWORD $DB  < $BASEDIR/create.sql`
        else
            echo "running default create statements."
            `mysql -u $DB_USER -p$DB_PASSWORD $DB  < /opt/gsat/default_create.sql`

    else
        echo "DB already exists. skipping"
    fi

}

migrate_get_version(){
    DB_VERSION=`mysql -u $DB_USER -p$DB_PASSWORD $DB -e "select version from patchlevel" --skip-column-names --raw `
    echo "current DB version is $DB_VERSION"
}


upgrade_to_latest(){
    echo "calculating latest version"
    UPGRADE_TO=`ls ${BASEDIR} -1 | grep -v create |  sed -e 's/\.[a-zA-Z]*$//' | sort -r -n | head -1`
    echo "latest version is $UPGRADE_TO"

    upgrade_to_version
}


upgrade_to_version(){
DB_VERSION=`mysql -u $DB_USER -p$DB_PASSWORD $DB -e "select version from patchlevel" --skip-column-names --raw `
echo "current DB version is $DB_VERSION"
if [ $DB_VERSION -ge $UPGRADE_TO ]; then
        echo "DB version is bigger. will not run migrate scripts"

else
        echo "upgrading to $UPGRADE_TO"
        DB_VERSION=` expr $DB_VERSION + 1 `
        for i in `seq $DB_VERSION $UPGRADE_TO`
        do
                CURR_FILE="$BASEDIR/$i.sql"
                if [ -f $CURR_FILE ]; then
                        echo "          migrating $CURR_FILE"
                        `mysql -u $DB_USER -p$DB_PASSWORD $DB  < $CURR_FILE`
                        RETVAL=$?
                        if [ "$RETVAL" -gt "0" ]; then
                                echo "failed migrating $i with error $RETVAL"
                                exit 1
                        else
                                `mysql -u $DB_USER -p$DB_PASSWORD $DB -e "update patchlevel set version=$i"`
                        fi
                else
                        echo "missing file $CURR_FILE"
                        exit 1
                fi
        done
fi
}


case "$UPGRADE_TO" in
  latest)
    upgrade_to_latest
    ;;
  create)
    migrate_create
    ;;
  version)
    migrate_get_version

    ;;
  *)
    upgrade_to_version

esac


echo "done migrating"

cd $CURRENT_DIR
