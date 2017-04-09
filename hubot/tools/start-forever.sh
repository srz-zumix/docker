#!/bin/sh

set -e

npm install
forever start -w -c coffee node_modules/.bin/hubot --name ${HUBOT_BOTNAME} -a ${HUBOT_ADAPTER} -d

