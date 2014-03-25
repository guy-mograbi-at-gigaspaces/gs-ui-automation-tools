
run_gsui_function_script( ){
    NAME=$1
    if [ ! -f $NAME.sh ]; then
        echo "missing file $NAME.sh"
        exit 1
    fi
    chmod +x $NAME.sh
    source $NAME.sh
}

install_java(){
    run_gsui_function_script install_java
}

install_mysql(){
    run_gsui_function_script install_mysql
}