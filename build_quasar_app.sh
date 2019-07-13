#!/bin/sh

build_quasar_app()
{
  QUASARAPPDIR=${1}
  MODE=${2}
  VER=${3}
  echo "Executing Quasar webfrontend build for ${QUASARAPPDIR}"
  cd ${QUASARAPPDIR}
  if [ -d ./dist ]; then
    rm -rf dist
  fi
  if [ -d ./dist ]; then
    echo "ERROR - failed to delete dist directory"
    exit 1
  fi
  eval npm install
  RES=$?
  if [ ${RES} -ne 0 ]; then
    echo ""
    echo "npm install failed for ${QUASARAPPDIR}"
    exit 1
  fi

  ecgi "Overwiting hard coded codebaseversion file ():"
  #must overwrite file not append so only single > 
  echo "export default {codebasever: '${VER}'}" > ./src/rjmversion.js


  eval quasar build -m ${MODE}
  RES=$?
  if [ ${RES} -ne 0 ]; then
    echo ""
    echo "Quasar build failed for ${QUASARAPPDIR}"
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

build_quasar_app ${QUASARAPPDIR} ${MODE} ${VER}

echo "End of ${0}"

exit 0
