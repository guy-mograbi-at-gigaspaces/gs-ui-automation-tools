# yum -y install npm

if [ -f /usr/bin/node ]; then
    echo "node already installed"
else
    NAVE=/opt/nave/nave.sh

    if [ ! -f nave.sh ]; then
        echo "downloading nave"
        mkdir -p /opt/nave
        run_wget -O $NAME https://raw.github.com/isaacs/nave/master/nave.sh
    fi
    chmod 755 $NAVE
    $NAVE install 0.10.18
    ln -Tfs ~/.nave/installed/0.10.18/bin/node /usr/bin/node
    ln -Tfs ~/.nave/installed/0.10.18/bin/npm /usr/bin/npm

fi