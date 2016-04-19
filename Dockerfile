FROM node:latest
COPY . /root/
RUN cd /root/; npm install --production
EXPOSE 8000
CMD ["node", "/root/app.js"]