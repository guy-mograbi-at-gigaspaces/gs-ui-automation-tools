# get all sysconf variables we have for play

CURRENT_DIR=`pwd`
echo "current dir is $CURRENT_DIR"

echo "changing workdir"
cd "$(dirname "$0")"
echo "workdir is now `pwd`"

if [ -z $DB_USER ] || [ -z $DB_PASSWORD ] || [ -z $DB ]; then
    echo "DB_USER, DB_PASSWORD and DB are required"
    exit 1
else
    echo "using $DB_USER/$DB_PASSWORD for upgrade on [ $DB ]"
fi


if [ -z $BASEDIR ]; then
    echo "BASEDIR is required"
    exit 1
else
    echo "BASEDIR is [ $BASEDIR ]"
fi


echo "upgrading to [ $1 ]"

UPGRADE_TO=$1

if [ "$UPGRADE_TO" = "create" ];then

    `mysql -u $DB_USER -p$DB_PASSWORD  -e "create database $DB"`
    `mysql -u $DB_USER -p$DB_PASSWORD $DB  < $BASEDIR/create.sql`
    exit 0
fi

if [ "$UPGRADE_TO" = "version" ];then
    DB_VERSION=`mysql -u $DB_USER -p$DB_PASSWORD $DB -e "select version from patchlevel" --skip-column-names --raw `
    echo "current DB version is $DB_VERSION"
    exit 0
fi


if [ "$UPGRADE_TO" = "" ];then
    echo "ERROR : missing argument version"
    echo "usage db_migrate version"
    exit 1
fi

if [ "$UPGRADE_TO" = "latest" ];then
    echo "calculating latest version"
    UPGRADE_TO=`ls ${BASEDIR} -1 | grep -v create |  sed -e 's/\.[a-zA-Z]*$//' | sort -r -n | head -1`
    echo "latest version is $UPGRADE_TO"
fi

echo "upgrading to $UPGRADE_TO"

DB_VERSION=`mysql -u $DB_USER -p$DB_PASSWORD $DB -e "select version from patchlevel" --skip-column-names --raw `
echo "current DB version is $DB_VERSION"
if [ $DB_VERSION -ge $UPGRADE_TO ]; then
        echo "DB version is bigger. will not run migrate scripts"
        exit 0
else
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

echo "done migrating"

cd $CURRENT_DIR