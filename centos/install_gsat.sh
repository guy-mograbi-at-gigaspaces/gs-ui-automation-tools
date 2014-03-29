# install gsat using the following command
# source "`wget --no-cache --no-check-certificate -O - http://get.gsdev.info/gsat/1.0.0/install_gsat.sh | dos2unix | bash`"
# this will automatically download and run gsui_functions.sh


echo "installing gsat"

if [ -e /opt/gsat ];then
    echo "deleting old version"
    rm -Rf /opt/gsat
fi

mkdir /opt/gsat
echo "download gsui_functions.sh"
wget --no-cache --no-check-certificate -O /opt/gsat/gsat.tar http://get.gsdev.info/gsat/1.0.0/gsat-1.0.0.tar
tar -xvf /opt/gsat/gsat.tar -C /opt/gsat
echo "loading gsat functions"
dos2unix  /opt/gsat/*.sh
chmod +x  /opt/gsat/*.sh
source /opt/gsat/gsui_functions.sh




