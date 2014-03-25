echo "installing java"
# find wget urls at : https://ivan-site.com/2012/05/download-oracle-java-jre-jdk-using-a-script/

DIST_FOLDER=/usr/lib/jvm/jdk1.6.0_33
if [ -f $DIST_FOLDER ];then
    echo "java already installed. skipping"
fi

CURRENT_DIRECTORY=`pwd`

cd "$(dirname "$0")"

INSTALL_JAVA_DIR=/usr/lib/jvm
mkdir -p $INSTALL_JAVA_DIR
cd $INSTALL_JAVA_DIR
wget -O jdk.bin http://get.gsdev.info/java/1.6_45/java-1.6_45-linux-x64.bin
chmod 755 jdk.bin
echo "yes" | ./jdk.bin &>/dev/null
export JAVA_HOME=$DIST_FOLDER
echo "JAVA_HOME is $JAVA_HOME"
rm -f jdk.bin
ln -Tfs $JAVA_HOME/bin/java /usr/bin/java
ln -Tfs $JAVA_HOME/bin/javac /usr/bin/javac

cd $CURRENT_DIRECTORY