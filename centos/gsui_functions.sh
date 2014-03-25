export GSUI_FUNCTION_ROOT="https://raw.githubusercontent.com/guy-mograbi-at-gigaspaces/gs-ui-automation-tools/master/centos"


run_gsui_function_script( NAME ){
    wget --no-check-certificate "$GSUI_FUNCTION_ROOT/$NAME.sh" -O $NAME.sh
    chmod +x $NAME.sh
    source $NAME.sh
}

install_mysql(){
    run_gsui_function_script install_mysql
}