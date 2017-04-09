FROM node:latest

MAINTAINER srz_zumix <zumix.cpp@gmail.com>

RUN apt-get update -q -y
RUN apt-get install -y wget vim iputils-ping sudo curl build-essential libssl-dev libicu-dev git
RUN nodejs -v
RUN npm -v

RUN npm install -g yo generator-hubot
RUN npm install -g forever

# make bot user
RUN groupadd -g 12345 bot && \
    useradd -g bot -G sudo -m -s /bin/bash bot && \
    echo 'bot:bot' | chpasswd
RUN chown bot.bot /home/bot
USER bot
WORKDIR /home/bot

# 
ENV LANG ja_JP.UTF-8


