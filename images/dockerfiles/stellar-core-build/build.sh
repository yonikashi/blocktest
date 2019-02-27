#!/usr/bin/env bash
set -e
set -x

cd /stellar-core

# prepare
./autogen.sh
./configure --enable-asan --enable-sdfprefs CXXFLAGS=-w

# make format

# build
make -j $(nproc) check && make -j $(nproc) && src/stellar-core --test -o stellartests.txt &> /dev/null
# test
# export ALL_VERSIONS=1
# make check

