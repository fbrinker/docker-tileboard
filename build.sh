#!/usr/bin/env bash

getVersionFromLatestRelease() {
    version=`curl -s "https://api.github.com/repos/resoai/TileBoard/releases/latest" \
        | grep "tag_name" \
        | cut -d '"' -f 4 \
        | sed -e "s/v//"`
    
    echo "$version"
}

getDownloadUrl() {
    url=`curl -s "https://api.github.com/repos/resoai/TileBoard/releases/latest" \
        | grep "browser_download_url" \
        | cut -d '"' -f 4`
    
    echo "$url"
}

getLatestPublishedTag() {
    latest_tag=`curl -s "https://hub.docker.com/v2/repositories/fbrinker/tileboard/tags?page_size=1" \
        | jq -r ".results[0].name"`

    echo "$latest_tag"
}

LATEST_RELEASE=`getVersionFromLatestRelease`
LATEST_TAG=`getLatestPublishedTag`

if [ "$LATEST_RELEASE" = "$LATEST_TAG" ]; then
    echo "Nothing to do. Versions already match."
    echo "Release: $LATEST_RELEASE"
    echo "Tag: $LATEST_TAG"
    #exit 78 # drone.io exit code to stop but success the pipeline
fi

SEMVER=( ${LATEST_RELEASE//./ } )
MAJOR=${SEMVER[0]}
MINOR=${SEMVER[0]}.${SEMVER[1]}
PATCH=$LATEST_RELEASE

echo "latest,$MAJOR,$MINOR,$PATCH" > .tags

RELEASE_URL=`getDownloadUrl`

echo "Writing $RELEASE_URL into Dockerfile..."
sed -i "s|%RELEASE_URL%|$RELEASE_URL|g" ./Dockerfile
