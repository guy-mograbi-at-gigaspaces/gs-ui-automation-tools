echo "verifying file ${1} exists"
if [ ! -f $1 ]; then
    echo "missing $1"
    exit 1
fi
