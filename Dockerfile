FROM node:20

WORKDIR /usr/src/app

COPY . .
RUN npm install
# RUN npm install -g pm2

# COPY ./scripts/wait-for-it.sh /usr/wait-for-it.sh
# RUN chmod +x /usr/wait-for-it.sh

ENV NAME World

CMD ["/bin/sh", "-c", "node server.js"]

# CMD ["/bin/sh", "-c", "node /usr/src/app/database/db-init.js && /usr/wait-for-it.sh db:3306 -- pm2-runtime start server.js"]
# CMD ["/bin/sh", "-c", "/usr/wait-for-it.sh db:3306 -- pm2-runtime start server.js"]