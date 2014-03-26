
run_gsui_function_script( ){
    NAME=$1
    if [ ! -f $NAME.sh ]; then
        echo "missing file $NAME.sh"
        exit 1
    fi
    chmod +x $NAME.sh
    source $NAME.sh
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
    if [ ! -f /etc/sysconfig/$SYSCONFIG_FILE ]; then
        echo "sysconfig file does not exists"
        exit 1
    else
        chmod +x /etc/sysconfig/$SYSCONFIG_FILE
        source /etc/sysconfig/$SYSCONFIG_FILE
    fi
}

install_java(){
    run_gsui_function_script install_java
}

install_mysql(){
    run_gsui_function_script install_mysql
}

install_nginx(){
    run_gsui_function_script install_nginx
}