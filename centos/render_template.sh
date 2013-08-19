# use it like so . ./render.sh hello.txt

echo "rendering [${1}]"
eval echo `cat $1 | sed "s/\"/\\\\\\\\\"/g"`