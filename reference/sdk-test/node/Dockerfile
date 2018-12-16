FROM node:10

ENV PORT 8080
ADD ./js /opt

RUN cd /opt && npm install

EXPOSE 8080

CMD ["npm","start"]