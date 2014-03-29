if [ -e /usr/bin/compass ]; then
    echo "compass already installed... skipping."
else
    gem install compass
fi