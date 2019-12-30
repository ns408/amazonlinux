#!/usr/bin/env bash
# Script to run the image

SCRIPTNAME="$(realpath $0)"
SCRIPTPATH="$(dirname $SCRIPTNAME)"

# `name` and `version` configured from here
source ${SCRIPTPATH}/../.info

docker run \
  -v ${SCRIPTPATH}/..:/home/${user}/host_mount \
  -v ${HOME}/.aws:/home/${user}/.aws \
  -u ${user} \
  -it ${name}:${version} /bin/bash \
  ${1}