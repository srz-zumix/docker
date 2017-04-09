FROM hubot-base-image

MAINTAINER srz_zumix <zumix.cpp@gmail.com>

# docker build --build-arg OWNER=hoge --build-arg BOTNAME=hoge --build-arg DESC=DESC --build-arg ADAPTER=irc
ARG OWNER=${USERNAME}
ARG BOTNAME
ARG ADAPTER=
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
COPY hubot-image/external-scripts.json external-scripts.json

COPY scripts scripts
COPY tools/start.sh start.sh
COPY tools/start-forever.sh start-forever.sh
COPY tools/stop-forever.sh stop-forever.sh

ENV PATH node_modules/.bin:node_modules/hubot/node_modules/.bin:${PATH}
