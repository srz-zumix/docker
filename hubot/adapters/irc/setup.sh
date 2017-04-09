#!/bin/sh

set -e

echo "Please enter some settings..."
echo "IRC <server> <port>"
read server port
echo "Connect rooms (e.g. room1,room2)"
read room

docker build `dirname $0` -t hubot-irc-image --build-arg IRC_SERVER=$server --build-arg IRC_PORT=$port --build-arg IRC_ROOMS=$room

echo "docker image create finish!!"
echo "docker run -itd --name <hoge> hubot-irc-image ./start.sh"
