FROM alpine:3.9

MAINTAINER Robert Metcalf

RUN apk add --no-cache nodejs npm && \
    npm install -g vue-cli && \
    npm install -g quasar-cli && \
    echo "done"

##docker build . -t metcarob/docker_build_quasar_app:latest
##docker run --rm --name docker_build_quasar_app -d metcarob/docker_build_quasar_app:latest

