#!/usr/bin/env bash

mkdir build && cd build

CUSTOM_SOURCE_DIR=${SRC_DIR}/source
INC_FLAGS="-I${PREFIX}/include/eigen3 -I${PREFIX}/include -O3 -L${PREFIX}/lib -lflann_cpp -O3 -std=c++11"

# if [ "$(uname)" = "Darwin" ]; then
#     cc_comp=clang
#     cxx_comp=clang++
# else
#     cc_comp=x86_64-conda-linux-gnu-gcc
#     cxx_comp=x86_64-conda-linux-gnu-c++
# fi
#   -DCMAKE_C_COMPILER=${PREFIX}/bin/$cc_comp    \
#   -DCMAKE_CXX_COMPILER=${PREFIX}/bin/$cxx_comp \

# Enforce a compiler we know to work
cmake                                          \
  -DCMAKE_BUILD_TYPE=Release                   \
  -DCMAKE_CXX_FLAGS="${INC_FLAGS}"             \
  -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX}        \
  -DCMAKE_PREFIX_PATH=${PREFIX}                \
  -DCMAKE_VERBOSE_MAKEFILE=ON                  \
  -DFastGlobalRegistration_LINK_MODE=SHARED    \
  ${CUSTOM_SOURCE_DIR}

make -j $CPU_COUNT

# Install
INC_DIR=${PREFIX}/include/FastGlobalRegistration
mkdir -p ${INC_DIR}
cp -fv ${CUSTOM_SOURCE_DIR}/FastGlobalRegistration/app.h ${INC_DIR}
LIB_DIR=${PREFIX}/lib
mkdir -p ${LIB_DIR}
cp -fv FastGlobalRegistration/libFastGlobalRegistrationLib* ${LIB_DIR}
