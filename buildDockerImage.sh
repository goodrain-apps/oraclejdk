#!/bin/bash

usage() {
  cat << EOF
Usage: buildDockerImage.sh -v [version] [Docker build option]
Builds a Docker Image for Oraclejdk
  
Parameters:
   -v: version to build
       Choose one of: $(for i in $(ls -d */); do echo -n "${i%%/}  "; done)
   -o: passes on Docker build option

Copyright (c) 2018 Goodrain and/or its affiliates. All rights reserved.
EOF
  exit 0
}



##############
#### MAIN ####
##############

if [ "$#" -eq 0 ]; then
  usage;
fi

# Parameters
VERSION="7u80"
DOCKEROPS=""

while getopts "hesxiv:o:" optname; do
  case "$optname" in
    "h")
      usage
      ;;
    "v")
      VERSION="$OPTARG"
      ;;
    "o")
      DOCKEROPS="$OPTARG"
      ;;
    "?")
      usage;
      exit 1;
      ;;
    *)
    # Should not occur
      echo "Unknown error while processing options inside buildDockerImage.sh"
      ;;
  esac
done

# prepare image

PRO_PATH=$PWD

cd $PRO_PATH/base

make all

cd ..

# Oracle JDK Image Name
IMAGE_NAME="goodrain-apps/oraclejdk:$VERSION"

# Go into version folder
cd $VERSION

echo "=========================="
echo "DOCKER info:"
docker info
echo "=========================="

# Proxy settings
PROXY_SETTINGS=""
if [ "${http_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg http_proxy=${http_proxy}"
fi

if [ "${https_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg https_proxy=${https_proxy}"
fi

if [ "${ftp_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg ftp_proxy=${ftp_proxy}"
fi

if [ "${no_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg no_proxy=${no_proxy}"
fi

if [ "$PROXY_SETTINGS" != "" ]; then
  echo "Proxy settings were found and will be used during the build."
fi

# ################## #
# BUILDING THE IMAGE #
# ################## #
echo "Building image '$IMAGE_NAME' ..."

# BUILD THE IMAGE (replace all environment variables)
BUILD_START=$(date '+%s')
docker build --force-rm=true --no-cache=true $DOCKEROPS $PROXY_SETTINGS -t $IMAGE_NAME -f Dockerfile . || {
  echo ""
  echo "ERROR: Docker Image was NOT successfully created."
  echo "ERROR: Check the output and correct any reported problems with the docker build operation."
  exit 1
}
echo ""
