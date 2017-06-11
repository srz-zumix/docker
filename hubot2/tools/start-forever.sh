#!/bin/sh

set -e

env
npm install
#forever start -w -c coffee node_modules/.bin/hubot --name ${HUBOT_BOTNAME}
rm -f ./hubot_log.log
touch ./hubot_log.log
forever start -w --watchIgnore '*.log' -o ./hubot_log.log -e ./hubot_err.log -c coffee node_modules/.bin/hubot --name ${HUBOT_BOTNAME}
tail -f ./hubot_log.log

/bin/bash
