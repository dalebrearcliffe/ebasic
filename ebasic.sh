#!/bin/bash

set -e

ELIBS="${EPIPHANY_HOME}/tools/host/lib"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${ELIBS}
EHDF=/opt/adapteva/esdk/bsps/current/parallella_E16G3_1GB.hdf

OS_MAJ="$(uname -a | cut -d' ' -f3 | cut -d'.' -f1)"
OS_VER="$(uname -a | cut -d' ' -f3 | cut -d'.' -f2)"

FILE=ebasic-host

if [ -f $FILE ]
then
FILE=./ebasic-host
else
FILE=/usr/bin/ebasic-host
fi

if [[ "$OS_VER" -ge "14" || "$OS_MAJ" -gt "3" ]]
then
$FILE "$@"
else
sudo -E LD_LIBRARY_PATH=${ELIBS} EPIPHANY_HDF=${EHDF} $FILE "$@"
fi
