#!/bin/sh

build_quasar_app()
{
  QUASARAPPDIR=${1}
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
  eval quasar build
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

build_quasar_app ${QUASARAPPDIR}

echo "End of ${0}"

exit 0
