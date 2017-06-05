#!/bin/sh

set -e

env
./bin/hubot --name ${HUBOT_BOTNAME} -a ${HUBOT_ADAPTER}

