if [ -e /etc/init.d/mongodb ]; then
    echo "mongo already installed... skipping"
else
    cp -f /opt/gsat/mongo.repo /etc/yum.repos.d/mogno.repo
    yum clean all
    yum install mongo-10gen mongo-10gen-server
fi
