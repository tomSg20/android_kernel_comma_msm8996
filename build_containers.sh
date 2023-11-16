#!/bin/bash

groups | grep docker
NEED_SUDO=$?

if [ $NEED_SUDO -eq 1 ]
then
	echo "Hey, we gonna use sudo for running docker"
	SUDO_CMD="sudo"
else
	echo "Hey, you are in docker group, sudo is not needed"
	SUDO_CMD=""
fi

set -e

build_gcc_container ()
{
 echo -e "\nBuilding a container with GCC_VERSION=$1 from UBUNTU_VERSION=$2"
 $SUDO_CMD docker build \
  --build-arg GCC_VERSION=$1 \
  --build-arg UBUNTU_VERSION=$2 \
  --build-arg UNAME=$(id -nu) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g)  \
  -t kernel-build-container:gcc-${GCC_VERSION} .
}

GCC_VERSION="4.9"
UBUNTU_VERSION="16.04"
build_gcc_container ${GCC_VERSION} ${UBUNTU_VERSION}
