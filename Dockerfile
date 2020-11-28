FROM alpine:3.9

MAINTAINER Robert Metcalf

RUN apk add --no-cache libxslt libxml2 nodejs npm pngquant pngcrush optipng gcc make libc-dev zlib zlib-dev bash-completion g++ pkgconfig autoconf automake libtool nasm build-base zlib-dev && \
    npm install -g vue-cli && \
    npm install -g @quasar/cli && \
    echo "done"

COPY build_quasar_app.sh /bin/build_quasar_app

ENTRYPOINT ["/bin/sh"]

##docker build . -t metcarob/docker_build_quasar_app:latest

##Get into image for testing
##docker run --rm --name docker_build_quasar_app --entrypoint /bin/sh -it metcarob/docker_build_quasar_app:latest


##Use image to build a quasar app
## docker run --rm --name docker_build_quasar_app --mount type=bind,source=$(pwd),target=/ext_volume metcarob/docker_build_quasar_app:latest -c "build_quasar_app /ext_volume"
