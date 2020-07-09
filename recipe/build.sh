#!/bin/bash

mkdir build_release
cd build_release

export CXXFLAGS="-fPIC ${CXXFLAGS}"
export CFLAGS="-fPIC ${CFLAGS}"

cmake ..  \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DINSTALL_HEADERS=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=OFF \
    -DBUILD_TESTING=ON
make
ctest
make install
