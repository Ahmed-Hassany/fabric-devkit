# Test image
FROM node:8.15 as test

RUN python --version

ENV PORT 8080
ADD ./js /opt/js
ADD ./package.json /opt/package.json

RUN cd /opt && npm install

EXPOSE 8080

CMD ["npm","test"]

# Production image
FROM node:8.15

ENV PORT 8080

WORKDIR /opt
COPY --from=test /opt/js /opt

RUN npm install

EXPOSE 8080

CMD ["npm","start"]