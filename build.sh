#!/usr/bin/env bash

getVersionFromLatestRelease() {
    version=`curl -s "https://api.github.com/repos/resoai/TileBoard/releases/latest" \
        | grep "tag_name" \
        | cut -d '"' -f 4 \
        | sed -e "s/v//"`
    
    echo "$version"
}

downloadLatestRelease() {
    URL=`curl -s "https://api.github.com/repos/resoai/TileBoard/releases/latest" \
        | grep "browser_download_url" \
        | cut -d '"' -f 4`
    echo "Url: $URL"
    
    curl -sL -o $1 ${URL}
}

LATEST=`getVersionFromLatestRelease`
SEMVER=( ${LATEST//./ } )

MAJOR=${SEMVER[0]}
MINOR=${SEMVER[0]}.${SEMVER[1]}
PATCH=$LATEST

echo "test,$MAJOR,$MINOR,$PATCH" > .tags

downloadLatestRelease "files.zip"

if [ ! -f "./files.zip" ]; then
    echo "Download ./files.zip does not exist"
    exit 1
fi

unzip files.zip -d files

if [ ! -d "./files" ]; then
    echo "Directory ./files does not exist"
    exit 1
fi

if [ ! -f "./files/index.html" ]; then
    echo "File ./files/index.html does not exist"
    exit 1
fi