
run_gsui_function_script( ){
    check_exists NAME
    chmod +x /opt/gsat/$NAME.sh
    source /opt/gsat/$NAME.sh $*
}

# checks if a variable is defined otherwise prints error message and exists. check_exists DOMAIN
check_exists(){
    TMP='eval echo \$$1'
    VAR_VALUE=`eval "$TMP"`
    if [ -z $VAR_VALUE ]; then
        echo "$1 must be defined for this template"
        exit 1
    else
        echo "$1 is $VAR_VALUE"
    fi

}


# use this with SYSCONFIG_FILE=filename read_sysconfig. This function will add /etc/sysconfig to the path
read_sysconfig(){
    check_exists SYSCONFIG_FILE
    if [ ! -f /etc/sysconfig/$SYSCONFIG_FILE ]; then
        echo "sysconfig file does not exists"
        exit 1
    else

        chmod +x /etc/sysconfig/$SYSCONFIG_FILE
        source /etc/sysconfig/$SYSCONFIG_FILE
    fi
}


# places a script under /etc/init.d. use with $SERVICE_NAME
install_initd_script(){
    echo "start install_initd_script"
    check_exists SERVICE_NAME
    echo "before check_exists SERVICE_FILE"
    check_exists SERVICE_FILE
    echo "installing initd script"
    INITD_LOCATION=/etc/init.d/$SERVICE_NAME
    echo "before dos2unix $SERVICE_FILE"
    dos2unix $SERVICE_FILE
    echo "before source $SERVICE_FILE > $INITD_LOCATION"


    if [ ! -h $INITD_LOCATION ];then
        echo "file [$INITD_LOCATION] exists but not a link. removing it."
        rm -f $INITD_LOCATION
    fi

    ln -Tfs $SERVICE_FILE $INITD_LOCATION
    echo "before chmod +x $INITD_LOCATION"
    chmod +x $INITD_LOCATION
    echo "initd script installed"

}

install_cloudify(){
    NAME=install_cloudify run_gsui_function_script
}

install_mongo(){
    NAME=install_mongo run_gsui_function_script
}

install_java(){
    NAME=install_java run_gsui_function_script
}

run_wget(){
    wget --no-cache --no-check-certificate $*
}

install_node(){

    NAME=install_node run_gsui_function_script
}

install_mysql(){
    NAME=install_mysql run_gsui_function_script
}

install_nginx(){
    NAME=install_nginx run_gsui_function_script
}

migrate_db(){
    NAME=migrate_db run_gsui_function_script $*
}

install_git(){
    NAME=install_git run_gsui_function_script
}

install_site_on_nginx(){
    cp $SITE_CONF /etc/nginx/sites-available
    ln -s /etc/nginx/sites-available /etc/nginx/sites-enabled
}

install_ruby(){
    NAME=install_ruby run_gsui_function_script $*
}

install_compass(){
    NAME=install_compass run_gsui_function_script
}