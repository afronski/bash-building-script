#! /bin/bash

# Little script to build openssl
# Author : Christophe Sonntag (https://github.com/c-sonntag)


# Add MINGW to path if is not set
export PATH=${PATH}:/r/my-mingw-folder/bin

# Set the system for the ./config script, 
# use "mingw64" for x64 build
export SYSTEM="mingw"

# Go in openssl folder
cd my-openssl-path

# Clean Build
make clean
if [ $? -eq 0 ]; then echo "OK : make clean"; else echo "FAIL : make clean"; exit;  fi

# Configure Build 
./config --prefix=$(pwd)/builds/mingw no-idea no-mdc2 no-rc5 shared
if [ $? -eq 0 ]; then echo "OK : ./config"; else echo "FAIL : ./config"; exit;  fi

# Check depend
make depend
if [ $? -eq 0 ]; then echo "OK : make depend"; else echo "FAIL : make depend"; exit;  fi

# Build with 8 jobs
make -j8
if [ $? -eq 0 ]; then echo "OK : make -j8"; else echo "FAIL : make -j8"; exit;  fi

# Install to prefix
make install_sw
if [ $? -eq 0 ]; then echo "OK : make install_sw"; else echo "FAIL : make install_sw"; exit;  fi

