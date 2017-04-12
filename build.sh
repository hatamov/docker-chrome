#!/bin/bash

TOP="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMAGE_NAME="comsgn/mipschrome:latest"


if [ ! -d chr/chromium/src ]; then
	echo "Downloading chromium sources";
	docker run -it --rm -v $TOP/chr:/chr $IMAGE_NAME /bin/bash -c "cd /chr/chromium && fetch --nohooks chromium"
fi

if [ -z `ls $TOP/chr/sysroots/` ]; then
	echo "Put sysroot to $TOP/sysroots/";
	exit 1;
fi

#docker run -it --rm -v $TOP/chr:/chr $IMAGE_NAME /chr/buildchrome.sh configs/56-gcc4.9
