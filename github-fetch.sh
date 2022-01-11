#!/bin/sh
# Download built GitHub OSTree repository artifact and unpack it into a plain directory
# https://github.com/martinpitt/ostree-pitti-workstation/blob/pitti-desktop-f35/github-fetch.sh
set -eux

# download latest repo build
CURL="curl -u token:$(echo $github_token) --show-error --fail"
RESPONSE=$($CURL --silent https://api.github.com/repos/$(echo $github_repo)/actions/artifacts)
ZIP=$(echo "$RESPONSE" | jq --raw-output '.artifacts | map(select(.name == "repository"))[0].archive_download_url')
echo "INFO: Downloading $ZIP ..."
[ -e /tmp/repository.zip ] || $CURL -L -o /tmp/repository.zip "$ZIP"
mkdir /tmp/repo
unzip -p /tmp/repository.zip | tar -xzC /tmp/repo
rsync --no-perms --no-group --no-owner -P --delete /tmp/repo/ /data
rm -rf /tmp/**
