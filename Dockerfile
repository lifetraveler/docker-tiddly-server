FROM node:alpine

RUN apk update && \
    apk add --no-cache tzdata
    
RUN apk add --no-cache --virtual .build-deps \
    git    
    

RUN mkdir -p /var/lib/tiddly-server \
 && chown -R node:node /var/lib/tiddly-server
 
VOLUME /var/lib/tiddly-server
WORKDIR /code

RUN npm install tiddlyserver

ENV TWS_PORT 8080
ENV TWS_SETTINGS_FILE /var/lib/tiddly-server/settings.json

EXPOSE ${TWS_PORT}

CMD node /code/node_modules/tiddlyserver/index.js --config ${TWS_SETTINGS_FILE} --stay-on-error
