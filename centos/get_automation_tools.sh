DEST_DIR=automation-tools
TEMP_DIR=gs-ui-automation-tools-master
TEMP_ZIP_FILE=$DEST_DIR.zip
GIT_URL=https://github.com/guy-mograbi-at-gigaspaces/gs-ui-automation-tools/archive/master.zip
SYSCONF_PATH=/etc/sysconfig/gs_ui_automation_tools

wget $GIT_URL -O $TEMP_ZIP_FILE
unzip $TEMP_ZIP_FILE
mv $TEMP_DIR $DEST_DIR
echo "AUTOMATION_TOOLS=automation_tools" > $SYSCONF_PATH
rm -f $TEMP_ZIP_FILE

echo "now you can run PATH=`. $SYSCONF_PATH; echo $SYSCONF_PATH`:$PATH"