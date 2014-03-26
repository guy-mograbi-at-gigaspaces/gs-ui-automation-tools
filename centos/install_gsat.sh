if [ ! -f /opt/gsat/gsui_functions.sh ]; then
    mkdir /opt/gsat
    echo "download gsui_functions.sh"
    wget --no-cache --no-check-certificate -O /opt/gsat/gsat.tar http://get.gsdev.info/gsat/1.0.0/gsat-1.0.0.tar
    tar -xvf /opt/gsat/gsat.tar
    echo "loading gsat functions"
    dos2unix *.sh /opt/gsat/*.sh
    chmod +x *.sh /opt/gsat/*.sh
else
    echo "gsat already installed"
fi

