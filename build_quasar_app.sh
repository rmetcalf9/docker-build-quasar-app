#!/bin/sh

build_quasar_app()
{
  QUASARAPPDIR=${1}
  MODE=${2}
  VER=${3}
  NODEMAXOLDSPACESIZE=${4}
  echo "Executing Quasar webfrontend build for ${QUASARAPPDIR}"
  cd ${QUASARAPPDIR}
  if [ -d ./dist ]; then
    rm -rf dist
  fi
  if [ -d ./dist ]; then
    echo "ERROR - failed to delete dist directory"
    exit 1
  fi
  if [ -d ./node_modules ]; then
    rm -rf node_modules
  fi
  if [ -d ./node_modules ]; then
    echo "ERROR - failed to delete node_modules directory"
    exit 1
  fi
  eval npm install
  RES=$?
  if [ ${RES} -ne 0 ]; then
    echo ""
    echo "npm install failed for ${QUASARAPPDIR}"
    exit 1
  fi

  echo "Overwiting hard coded codebaseversion file ():"
  #must overwrite file not append so only single >
  echo "/* eslint-disable */" > ./src/rjmversion.js
  echo "export default { codebasever: '${VER}' }" >> ./src/rjmversion.js


  if test "E${NODEMAXOLDSPACESIZE}" = "NOTSET"
  then
    echo "CMD: eval quasar build -m ${MODE}"
    eval quasar build -m ${MODE}
    RES=$?
  else
    echo "CMD: eval NODE_OPTIONS=--max-old-space-size=${NODEMAXOLDSPACESIZE} quasar build -m ${MODE}"
    eval NODE_OPTIONS=--max-old-space-size=${NODEMAXOLDSPACESIZE} quasar build -m ${MODE}
    RES=$?
  fi

  eval quasar build -m ${MODE}
  RES=$?
  if [ ${RES} -ne 0 ]; then
    echo ""
    echo "Quasar build failed for ${QUASARAPPDIR}"
    echo "Command was: quasar build -m ${MODE}"
    exit 1
  fi
  if [ ! -d ./dist ]; then
    echo "ERROR - build command didn't create ${QUASARAPPDIR}/dist directory"
    exit 1
  fi
}

echo "Start of ${0}"
QUASARAPPDIR=${1}
if test "E${QUASARAPPDIR}" = "E"
then
  echo "Must specify App directory"
  exit 1
fi
if [ ! -d ${QUASARAPPDIR} ]; then
  echo "App directory dosen't exist: ${QUASARAPPDIR}"
  exit 1
fi

MODE=${2}
if test "E${MODE}" = "E"
then
  echo "Defaulting mode to spa"
  MODE=spa
else
  echo "Passed mode: ${MODE}"
fi
VER=${3}
if test "E${VER}" = "E"
then
  echo "Defaulting VER to spa not_set_in_build"
  VER=not_set_in_build
else
  echo "Passed ver: ${VER}"
fi

NODEMAXOLDSPACESIZE=${4}
if test "E${NODEMAXOLDSPACESIZE}" = "E"
then
  NODEMAXOLDSPACESIZE=NOTSET
fi

build_quasar_app ${QUASARAPPDIR} ${MODE} ${VER} ${NODEMAXOLDSPACESIZE}
RES=$?

echo "End of ${0} - RES=${RES}"

exit ${RES}
