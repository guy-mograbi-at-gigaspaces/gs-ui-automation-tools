export GSUI_FUNCTION_ROOT="https://raw.githubusercontent.com/guy-mograbi-at-gigaspaces/gs-ui-automation-tools/master/centos"


run_gsui_function_script( ){

    NAME = $1
    wget --no-check-certificate "$GSUI_FUNCTION_ROOT/$1.sh" -O $1.sh
    chmod +x $NAME.sh
    source $NAME.sh
}

install_java(){
    run_gsui_function_script install_java
}

install_mysql(){
    run_gsui_function_script install_mysql
}
