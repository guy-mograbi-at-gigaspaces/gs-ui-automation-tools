if [ -e /etc/init.d/nginx ]; then
    echo "nginx already installed. skipping"
else
    echo "installing nginx"
    cp -f /opt/gsat/nginx.repo /etc/yum.repos.d/nginx.repo
    yum clean all
    yum -y install nginx


    echo "copying nginx configuration file"

    if [ -e /etc/nginx/nginx_conf_backup ]; then
        echo "I suspect nginx configuration already copied. Not copying again"
    else
        echo "overriding nginx configuration"
        mv /etc/nginx/nginx.conf /etc/nginx/nginx_conf_backup
        cp /opt/gsat/nginx.conf /etc/nginx/nginx.conf
        mkdir -p /etc/nginx/sites-enabled
        mkdir -p /etc/nginx/sites-available
        service nginx restart
    fi
fi
