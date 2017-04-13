#This repo contains tools to automate chromium builds for MIPS32.

#Structure:
.
├── build.sh
├── chr        # This dir will be attached as volume to docker container
│   ├── buildchrome.sh  # This script runs in container and automates build
│   ├── chromium   
│   │   └── src    # Chromium source code 
│   ├── configs    # Configs for building various versions of chrome
│   │   ├── 56-gcc4.9  
│   │   ├── 56-gcc5.4
│   │   └── ....
│   ├── sysroots   # Must contain sysroots for builds
│   │   │── baikal-rootfs-chromedeps # must be downloaded manualy
│   │   └── yocto-fp64-sysroot 
│   │   └── .....
│   └── toolchains # Must contain toolchains
│       │── mipsel-gcc4.9-crosstool-ng
│       │── baikal-gcc5.2
│       └── .....
├── docker_image
│   └── Dockerfile                          
└── Readme.md

#Usage

0. Install docker and read this readme completely before start
1. Unpack your sysroot in ``chr/sysroots/`` 
2. Install additional toolchains in ``chr/toolchains/`` (except for gcc-5.4)
3. Run 

    ``./build.sh config_name build_name``

    * First argument is dirname containing config (must not contain slashes)
    * Second argument is output dirname. You can ommit it and in that case same value as ``config_name`` will be used.
    
    Example:

        ``./build.sh 56-gcc5.4``

4. After build finishes you can make archive with build result:
    
    ```
    cd chr/chromium/src/out/my_build_name
    tar -cvzf /dest/dir/my-custom-chromium-build.tar.gz --exclude='./obj' --exclude='./gen' --exclude='./clang_x86_v8_mipsel' --exclude='./x64'  --exclude='./clang_x86' .
    ```

#Notes and recommendations
    
* For docker image automated is configured https://hub.docker.com/r/comsgn/mipschrome/
* Docker container runs as nonroot user "builder"(uid=1000). Thus it is recommended to clone repo and run all commands with host user having same uid value. Also you can create new user in image having desired uid.
* Docker image is built with dependencies for 56.0.2924.122 version of chrome. It is sufficient for building chromium of 54-57 versions, but may require update for newer versions.
* Docker image contains gcc-5.4 croos compilation toolchain. In order to build with other toolchains you must install them to ``chr/toolchains/``
* Most of predefined configurations in ``chr/configs`` were tested with "baikal-rootfs-chromedeps" sysyroot that can be downloaded at [todo add link to ftp]
* First time ``build.sh`` called it will automatically download chromium sources to ``chr/chromium/src``. Chromium repo have huge size(about 17GB), so it may take long time.




