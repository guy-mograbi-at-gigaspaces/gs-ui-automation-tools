if [ -e /usr/bin/ruby ]; then
    echo "ruby already installed... skipping"
else
    echo "installing ruby stuff"
    yum install -y ruby ruby-devel rubygems gcc make libxml2 libxml2-devel libxslt libxslt-devel
fi