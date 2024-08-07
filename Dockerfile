FROM node:20

WORKDIR /usr/src/app

COPY . .
RUN npm install
RUN npm install -g pm2

COPY ./scripts/wait-for-it.sh /usr/wait-for-it.sh
RUN chmod +x /usr/wait-for-it.sh

EXPOSE 3001

ENV NAME World

CMD ["/bin/sh", "-c", "/usr/wait-for-it.sh db:3306 -- pm2-runtime start server.js"]