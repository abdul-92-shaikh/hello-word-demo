#!/bin/bash
set -e
set -x

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [ $# -ne 3 ]
  then
    echo "Usage: $0 <repo> <tag> <target>"
    exit 1
fi

REPO=$1
TAG=$2
TARGET=$3

#
# Perform build
#

if [ "$TARGET" = "development" ]; then
  docker buildx build --push --platform linux/arm64/v8,linux/amd64 -t $REPOSITORY:$TAG .
elif [ "$TARGET" = "production" ]; then
  docker builder build --platform linux/amd64 -t $REPOSITORY:$TAG .
  docker push $REPOSITORY:$TAG
else
  echo "ERROR: target ${TARGET} not supported"
  exit 1
fi
