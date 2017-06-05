#!/bin/sh

set -e

env
npm install
forever start -w -c coffee node_modules/.bin/hubot --name ${HUBOT_BOTNAME} -a ${HUBOT_ADAPTER}

/bin/bash
