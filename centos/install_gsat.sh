# install gsat using the following command
# wget --no-cache --no-check-certificate -O - http://get.gsdev.info/gsat/1.0.0/install_gsat.sh | dos2unix | bash
# and then use by running
# source /opt/gsat/gsui_function.sh

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
dos2unix *.sh /opt/gsat/*.sh
chmod +x *.sh /opt/gsat/*.sh
source /opt/gsat/gsui_functions.sh




