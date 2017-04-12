FROM buildpack-deps:xenial

RUN set -ex; \
	echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list && \
	echo "deb-src http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y vim htop tree tmux sudo bash-completion ttf-mscorefonts-installer apt-utils && \
	git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /opt/depot_tools

ENV PATH="$PATH:/opt/depot_tools"

ARG deps_script_revision="56.0.2924.122"

RUN curl "https://chromium.googlesource.com/chromium/src/+/$deps_script_revision/build/install-build-deps.sh?format=TEXT" \
      | base64 -d > /tmp/install-build-deps.sh &&  \
    chmod +x /tmp/install-build-deps.sh && \
	/tmp/install-build-deps.sh --no-prompt --no-syms --no-arm --no-chromeos-fonts --no-nacl && \
	apt-get install -y g++-5-multilib-mipsel-linux-gnu gcc-5-multilib-mipsel-linux-gnu \
		               libc6-dev-mipsel-cross linux-libc-dev-mipsel-cross g++-multilib-mipsel-linux-gnu \
		               gcc-multilib-mipsel-linux-gnu ;
