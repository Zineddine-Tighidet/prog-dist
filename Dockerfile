FROM node:latest

RUN mkdir -p /usr/src/app

RUN apt-get update

RUN apt-get install nano

WORKDIR /usr/src/app

COPY package.json /usr/src/app/

RUN rm -rf /var/lib/postgresql/data/

RUN npm install

COPY . /usr/src/app

# CMD ["npm", "start"]