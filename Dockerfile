FROM alpine:latest

WORKDIR /app

COPY onStart.sh .

RUN apk update && apk add inotify-tools curl 

CMD ./onStart.sh

