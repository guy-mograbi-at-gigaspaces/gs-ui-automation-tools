# rerunable script used for installing/updating cloudify


check_exists CLOUDIFY_URL

echo "removing last cloudify.zip download"
rm -f /tmp/cloudify.zip

echo "getting current install url version"

mkdir -p /etc/gsat
CLOUDIFY_CURRENT_URL=`cat /etc/gsat/cloudify_url_version`

echo "comparing [$CLOUDIFY_URL] to [$CLOUDIFY_CURRENT_URL]"
if [ "$CLOUDIFY_URL" = "$CLOUDIFY_CURRENT_URL" ]; then
    echo "same cloudify version, nothing to install"
else
    rm -Rf /usr/lib/cloudify
    echo "wgetting cloudify from $CLOUDIFY_URL"
    wget --no-check-certificate $CLOUDIFY_URL -O /tmp/cloudify.zip

    unzip -q /tmp/cloudify.zip -d /usr/lib/cloudify
    echo "recreating the link"

    GIGASPACES_FOLDER=`ls /usr/lib/cloudify/ | grep giga`


    echo "saving url to file"
    echo $CLOUDIFY_URL > /etc/gsat/cloudify_url_version
    rm -f /tmp/cloudify.zip
fi


if [ -z CLOUDIFY_OVERRIDES ] || [ ! -e CLOUDIFY_OVERRIDES ]; then
    echo "cloudify overrides is undefined. not overriding anything"
else
    echo "overriding cloudify configuration with files under [$CLOUDIFY_OVERRIDES]. I will copy the entire directory structure on top of cloudify"
    \cp -f $CLOUDIFY_OVERRIDES /usr/lib/cloudify
fi




