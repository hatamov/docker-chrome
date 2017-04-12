#!/bin/bash
set -ex

CONFIG_DIR=$1
source $CONFIG_DIR/vars.sh

cd $PATH_TO_CHROMIUM_SRC_DIR

# Name of output directory
BUILD_NAME="${BUILD_NAME:-$(basename $CONFIG_DIR)}"

export PATH="$PATH_TO_TOOCHAIN_BIN_DIR:${PATH}"

# Checkout necessary revision
git checkout "$CHROMIUM_REVISION"
gclient sync  --with_branch_heads

# Apply patches
for patchfile in $CONFIG_DIR/*.patch
do
	patch -p1 patchfile
done

# Prepare build configuration
OUT_DIR="out/$BUILD_NAME"
mkdir $OUT_DIR
cp "$GN_ARGS_FILE_PATH" $OUT_DIR/args.gn
gn gen "$OUT_DIR" 

# Start build
ninja -C $OUT_DIR chrome chrome_sandbox
