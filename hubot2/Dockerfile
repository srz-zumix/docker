FROM node:latest

MAINTAINER srz_zumix <zumix.cpp@gmail.com>

RUN apt-get update -q -y
RUN apt-get install -y wget vim iputils-ping sudo curl build-essential libssl-dev libicu-dev git
RUN apt-get install net-tools
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

# docker build --build-arg OWNER=hoge --build-arg BOTNAME=hoge --build-arg DESC=DESC --build-arg ADAPTER=irc
ARG OWNER=bot
ARG BOTNAME
ARG ADAPTER
ARG DESC=hubot
ENV HUBOT_ADAPTER ${ADAPTER}
ENV HUBOT_BOTNAME ${BOTNAME}
RUN echo --owner ${OWNER} --name ${BOTNAME} --description ${DESC} --adapter ${ADAPTER}

RUN yo hubot --owner ${OWNER} --name ${BOTNAME} --description ${DESC} --adapter ${ADAPTER}

RUN npm install --save cheerio-httpcli
RUN npm install --save cron
RUN npm install --save hubot-reload-scripts
RUN npm install --save hubot-alias

RUN rm -rf hubot-scripts.json
COPY external-scripts.json external-scripts.json

#RUN rm -rf scripts
COPY scripts scripts
COPY tools/start-forever.sh start-forever.sh
COPY tools/stop-forever.sh stop-forever.sh
COPY tools/start.sh start.sh

# 
ENV LANG ja_JP.UTF-8
ENV PATH node_modules/.bin:node_modules/hubot/node_modules/.bin:${PATH}


ENV HUBOT_IRC_USERNAME ${HUBOT_BOTNAME}
ENV HUBOT_IRC_NICK ${HUBOT_BOTNAME}

