#!/usr/bin/env bash
set -e
set -x

cd /stellar-core

# prepare
./autogen.sh
./configure --enable-asan --enable-sdfprefs CXXFLAGS=-w

# make format

wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip
echo "Decompressing ScannerQube"
unzip sonar-scanner-cli-3.2.0.1227-linux.zip -d .
echo "Setting Enviroment Variable for Scanner"
export PATH=.sonar-scanner-cli-3.2.0.1227-linux/bin:$PATH

wget https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip
echo "Decompressing Build Wrapper"
unzip build-wrapper-linux-x86.zip -d .
echo "Setting Enviroment variable for Wrapper"
export PATH=./build-wrapper-linux-x86:$PATH

build-wrapper-linux-x86-64 --out-dir bw-output make clean all

sonar-scanner \
  -Dsonar.projectKey=blocktest \
  -Dsonar.organization=yonikashi-github \
  -Dsonar.sources=. \
  -Dsonar.cfamily.build-wrapper-output=bw-output \
  -Dsonar.host.url=https://sonarcloud.io \
  -Dsonar.login=baba8bed9b8a116f2517dfc494139f42ae20c3b0


# build
#make -j $(nproc)

# test
# export ALL_VERSIONS=1
# make check
