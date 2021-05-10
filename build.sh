#!/usr/bin/env bash

getVersionFromLatestRelease() {
    repo="${1-resoai/TileBoard}"
    version=`curl -s "https://api.github.com/repos/$repo/releases/latest" \
        | grep "tag_name" \
        | cut -d '"' -f 4 \
        | sed -e "s/v//"`

    echo "$version"
}

getDownloadUrl() {
    repo="${1-resoai/TileBoard}"
    url=`curl -s "https://api.github.com/repos/$repo/releases/latest" \
        | grep "browser_download_url" \
        | cut -d '"' -f 4`

    echo "$url"
}

docker_tag_exists() {
    repo="${1-fbrinker/tileboard}"
    tag="${2-latest}"
    curl --silent -f -lSL "https://hub.docker.com/v2/repositories/$repo/tags/$tag" > /dev/null 2>&1
}

source_repo="${1-resoai/TileBoard}"
docker_repo="${2-fbrinker/tileboard}"
echo "Source repository: $source_repo."
echo "Docker repository: $docker_repo."

LATEST_RELEASE=`getVersionFromLatestRelease $source_repo`
echo "Latest release is: $LATEST_RELEASE."

if docker_tag_exists $docker_repo $LATEST_RELEASE; then
    echo "Nothing to do. Latest release tag already exists."
    exit 78 # drone.io exit code to stop but success the pipeline
fi

SEMVER=( ${LATEST_RELEASE//./ } )
MAJOR=${SEMVER[0]}
MINOR=${SEMVER[0]}.${SEMVER[1]}
PATCH=$LATEST_RELEASE

echo "latest,$MAJOR,$MINOR,$PATCH" > .tags

RELEASE_URL=`getDownloadUrl`
echo "URL of release is: $RELEASE_URL."

echo "Writing release URL into Dockerfile..."
sed -i "s|%RELEASE_URL%|$RELEASE_URL|g" ./Dockerfile
