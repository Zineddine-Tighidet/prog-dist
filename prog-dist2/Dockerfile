FROM node:latest

RUN mkdir -p /usr/src/app

RUN apt-get update

RUN apt-get install nano

WORKDIR /usr/src/app

COPY package.json /usr/src/app/

RUN npm install

COPY . /usr/src/app

EXPOSE 4000
CMD ["node", "server.js"]