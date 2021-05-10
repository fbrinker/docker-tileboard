#!/usr/bin/env bash

commitdate=$(curl -sL "https://api.github.com/repos/resoai/TileBoard/commits/master" | jq -r ".commit.author.date")
commitdays=$(( ( $(date --utc +%s) - $(date --utc -d $commitdate +%s) ) / 86400 ))
echo "Last commit was $commitdays days ago."

if [ $commitdays -lt 2 ] ; then
  echo "There ARE recent changes in the repository."
else
  echo "There are NO recent changes in the repository."
  echo "Aborting pipeline."
  exit 78 # drone.io exit code to stop but success the pipeline
fi