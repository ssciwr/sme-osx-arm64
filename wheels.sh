#!/bin/bash

# Arm64 MacOS Python wheels build script

set -e -x

export CMAKE_PREFIX_PATH="/opt/smelibs;/opt/smelibs/lib/cmake"
export CMAKE_ARGS="-DCMAKE_OSX_DEPLOYMENT_TARGET=$MACOSX_DEPLOYMENT_TARGET -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH -DSME_BUILD_CORE=off"

# build and install sme::core
cd spatial-model-editor
mkdir build
cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/smelibs \
    -DBUILD_TESTING=on \
    -DSME_BUILD_BENCHMARKS=off \
    -DSME_BUILD_CLI=off \
    -DSME_BUILD_GUI=off \
    -DSME_BUILD_PYTHON_LIBRARY=off \
    -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH \
    -DSME_LOG_LEVEL=OFF \
    -DSME_BUILD_CORE=on
make -j5 core tests
ctest -j5
sudo make install
cd ..

python -m pip install cibuildwheel==${CIBUILDWHEEL_VERSION}
python -m cibuildwheel --output-dir wheelhouse