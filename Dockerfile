FROM node:20-bookworm

MAINTAINER Robert Metcalf

# System dependencies for builds
RUN apt-get update && apt-get install -y \
    bash \
    git \
    python3 \
    make \
    g++ \
    pkg-config \
    build-essential \
    openjdk-17-jdk \
    libc6 \
    && rm -rf /var/lib/apt/lists/*

# Global Node tooling
RUN npm install -g \
    @quasar/cli \
    vue-cli

# Copy your script
COPY build_quasar_app.sh /bin/build_quasar_app
RUN chmod +x /bin/build_quasar_app

ENTRYPOINT ["/bin/bash"]


##docker build . -t metcarob/docker_build_quasar_app:latest

##Get into image for testing
##docker run --rm --name docker_build_quasar_app --entrypoint /bin/sh -it metcarob/docker_build_quasar_app:latest


##Use image to build a quasar app
## docker run --rm --name docker_build_quasar_app --mount type=bind,source=$(pwd),target=/ext_volume metcarob/docker_build_quasar_app:latest -c "build_quasar_app /ext_volume"
