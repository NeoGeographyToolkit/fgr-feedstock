#!/usr/bin/env bash

cd source
mkdir build && cd build

# Make libraries
cmake                                          \
  -DCMAKE_BUILD_TYPE=Release                   \
  -DCMAKE_CXX_FLAGS='-g -O3 -std=c++11'        \
  -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX}        \
  -DCMAKE_PREFIX_PATH=${PREFIX}                \
  -DCMAKE_VERBOSE_MAKEFILE=ON                  \
  -DFastGlobalRegistration_LINK_MODE=SHARED    \
  ${SRC_DIR}

make -j $CPU_COUNT

# Install
INC_DIR=${PREFIX}/include/FastGlobalRegistration
mkdir -p ${INC_DIR}
cp -fv ${SRC_DIR}/FastGlobalRegistration/app.h ${INC_DIR}
LIB_DIR=${PREFIX}/lib
mkdir -p ${LIB_DIR}
cp -fv FastGlobalRegistration/libFastGlobalRegistrationLib* ${LIB_DIR}
