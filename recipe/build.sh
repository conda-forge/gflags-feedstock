#!/bin/bash

mkdir build_release
cd build_release

export CXXFLAGS="-fPIC ${CXXFLAGS}"
export CFLAGS="-fPIC ${CFLAGS}"

cmake ${CMAKE_ARGS} ..  \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DINSTALL_HEADERS=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=ON \
    -DBUILD_TESTING=ON
make
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
ctest
fi
make install
