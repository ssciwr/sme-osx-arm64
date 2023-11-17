#!/bin/bash

# MacOS Arm64 GUI/CLI init script

set -e -x

# clone sme
git clone --recursive --depth 1 -b ${SME_VERSION} https://github.com/spatial-model-editor/spatial-model-editor

# download static deps
wget "https://github.com/ssciwr/sme-deps-osx-arm64/releases/download/${SME_DEPS_VERSION}/sme_deps_${OS_TARGET}.tgz"
$SUDOCMD tar xf "sme_deps_${OS_TARGET}.tgz" -C /
