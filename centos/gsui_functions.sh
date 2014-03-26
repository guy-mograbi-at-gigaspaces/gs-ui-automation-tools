
run_gsui_function_script( ){
    check_exists NAME
    chmod +x /opt/gsat/$NAME.sh
    source /opt/gsat/$NAME.sh
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
    check_exists SERVICE_NAME
    check_exists SERVICE_FILE
    echo "installing initd script"
    INITD_LOCATION=/etc/init.d/$SERVICE_NAME

    dos2unix $SERVICE_FILE
    source $SERVICE_FILE > $INITD_LOCATION
    chmod +x $INITD_LOCATION
    echo "initd script installed"

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