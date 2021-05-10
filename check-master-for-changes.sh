#!/usr/bin/env bash

docker_tag_exists() {
    repo="${1-fbrinker/tileboard}"
    tag="${2-nightly}"
    curl --silent -f -lSL "https://hub.docker.com/v2/repositories/$repo/tags/$tag" > /dev/null 2>&1
}

commitdate=$(curl -sL "https://api.github.com/repos/resoai/TileBoard/commits/master" | jq -r ".commit.author.date" | sed 's/T/ /; s/Z//')
commitdays=$(( ( $(date --utc +%s) - $(date --utc -d "$commitdate" +%s) ) / 86400 ))
echo "Last commit was $commitdate and is $commitdays days ago."

if [ $commitdays -lt 2 ]; then
  echo "Found recent commits in the repository."
  echo "Continuing with pipeline..."
elif ! docker_tag_exists; then
  echo "Missing an nightly build."
  echo "Continuing with pipeline..."
else
  echo "No recent commits found."
  echo "Aborting pipeline."
  exit 78 # drone.io exit code to stop but success the pipeline
fi