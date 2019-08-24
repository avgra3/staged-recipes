#!/bin/bash

mkdir -p ${PREFIX}/bin

if [ $(uname) == Linux ]; then
        mv * ${PREFIX}/bin
fi

if [ $(uname) == Darwin ]; then
  pkgutil --expand firefox.pkg firefox
  cpio -i -I Firefox $VERSION.pkg/Payload
  cp usr/local/bin/* ${PREFIX}/bin/
fi
