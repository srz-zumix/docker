#!/bin/sh

set -e

if [ $# -lt 2 ]; then
  echo "Usage: create.sh <adapter> <botname>" 1>&2
  exit 1
fi

if [ ! "$OWNER" ]; then
  OWNER=S{USERNAME}
fi

# build base-image
docker build . -f base-image/Dockerfile -t hubot-base-image

# build hubot-image
docker build . -f hubot-image/Dockerfile -t hubot-image --build-arg ADAPTER=$1 --build-arg BOTNAME=$2 --build-arg OWNER=${OWNER}

# build for adapter
if [ -e ./adapters/$1 ]; then
  ./adapters/$1/setup.sh
else
  echo "$1 is not supported..."
  echo "please setup yourself."
  exit 1
fi

