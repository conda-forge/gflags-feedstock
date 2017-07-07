#!/bin/bash

mkdir build_release
cd build_release
cmake ..  \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DINSTALL_HEADERS=on \
    -DBUILD_SHARED_LIBS=on \
    -DBUILD_STATIC_LIBS=on \
    -DBUILD_TESTING=on
make
ctest
make install

if [[ `uname` == Linux ]]; then
    # Create the *.so.2 shared libraries needed by downstreammpackages (caffe).
    # Similar files are not needed on macOS as no downstream packages have been
    # found which depend on them.
    cd $PREFIX/lib
    ln -s libgflags.so.2.2.0 libgflags.so.2
    ln -s libgflags_nothreads.so.2.2.0 libgflags_nothreads.so.2
fi
