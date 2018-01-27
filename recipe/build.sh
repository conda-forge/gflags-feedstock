#!/bin/bash

mkdir build_release
cd build_release

export CXXFLAGS="-fPIC ${CXXFLAGS}"
export CFLAGS="-fPIC ${CFLAGS}"

cmake ..  \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DINSTALL_HEADERS=on \
    -DBUILD_SHARED_LIBS=on \
    -DBUILD_STATIC_LIBS=on \
    -DBUILD_TESTING=on
make
ctest
make install
