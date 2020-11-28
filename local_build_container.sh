#!/bin/bash

source ./coderelease.props
VERSIONNUM=$(cat ./VERSION)

eval docker build . -t ${DOCKER_USERNAME}/${DOCKER_IMAGENAME}:${VERSIONNUM}_localbuild
RES=$?
if [ ${RES} -ne 0 ]; then
  echo ""
  echo "Docker build failed"
  exit 1
fi

echo "now..."
echo "docker login"
echo "docker push ${DOCKER_USERNAME}/${DOCKER_IMAGENAME}:${VERSIONNUM}"

exit 0

