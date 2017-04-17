#!/bin/sh

set -e

echo "Please enter some settings..."
echo "SLACK_TOKEN <token>"
read token
#echo "Connect team (e.g. team1,team2)"
#read team

docker build `dirname $0` -t hubot-slack-image --build-arg SLACK_TOKEN=$token
#docker build `dirname $0` -t hubot-slack-image --build-arg SLACK_TOKEN=$token --build-arg SLACK_TEAM=$team

echo "docker image create finish!!"
echo "docker run -itd --name <hoge> hubot-slack-image ./start.sh"
