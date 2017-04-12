#!/bin/bash

TOP=`dirname "$BASH_SOURCE"`
cd $TOP

IMAGE_NAME="comsgn/"
SYSROOT_URL=""

if [ -z `ls chr/chromium/` ]; then
	mkdir chr/chromium;
	echo "Downloading chromium sources";
	docker run -it --rm -v $TOP/chr:/chr $IMAGE_NAME /bin/bash -c "cd /chr/chromium && fetch --nohooks chromium"
fi


if [ -z `ls $TOP/chr/sysroots/` ]; then
	echo "Put sysroot to $TOP/sysroots/";
	exit 1;
fi

docker run -it --rm -v $TOP/chr:/chr $IMAGE_NAME /chr/buildchrome.sh configs/56.0.2924.122
