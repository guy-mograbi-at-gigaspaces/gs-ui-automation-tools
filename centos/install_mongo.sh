if [ -e /etc/init.d/mongod ]; then
    echo "mongo already installed... skipping"
else
    \cp -f /opt/gsat/mongo.repo /etc/yum.repos.d/mogno.repo
    yum clean all
    yum -y install mongo-10gen mongo-10gen-server
fi
