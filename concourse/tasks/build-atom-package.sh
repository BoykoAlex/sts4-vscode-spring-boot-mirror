#!/bin/bash
set -e
set -v
workdir=`pwd`
output=$workdir/out

url=`cat fatjar/url`

echo "The url of the fatjar is ${url}"

ls -la

cd package_sources

npm install ../sts4/atom-extensions/atom-commons

cat > properties.json << EOF
{
    jarUrl: ${url}
}
EOF

npm install

npm install bundle-deps

node ./node_modules/bundle-deps/bundle-deps .

basename=$(npm pack | tee /dev/tty)

timestamp=`date -u +%Y%m%d%H%M`

length=${#basename}

newName=${basename:0:${length}-4}-$timestamp${basename:${length}-4:${length}}

cp ${basename} $output/${newName}

cd $output
ls -la