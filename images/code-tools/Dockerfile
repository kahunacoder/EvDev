# Docker stage we'll use later for the CLI
FROM ubuntu:18.04 AS docker

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg-agent \
	software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
	apt-get update && \
	apt-get install -y docker-ce-cli


# The tools image for code-server
FROM ubuntu:18.04

ENV PATH=/home/coder/.rbenv/bin::/home/coder/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ARG PUID=1001
ARG PGID=1001
ARG TZ=America/New_York
ARG ssh_prv_key
ARG ssh_pub_key

COPY fonts /usr/share/fonts/truetype


COPY scripts /home/coder/scripts

RUN apt-get update && \
	apt-get install -y apt-utils locales && \
	locale-gen en_US.UTF-8
# Locale Generation
# We unfortunately cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN apt-get install -y curl gnupg2 ca-certificates git wget unzip sudo openssh-server \
	# Terminal Preferences
	zsh mosh tmux powerline fonts-powerline zsh-theme-powerlevel9k zsh-syntax-highlighting \
	ansible \
	# Dev Tools
	build-essential pass xz-utils openssl net-tools \
	# Pyhton and Pip
	python3 python3-pip \
	# Ruby Dependencies
	libssl-dev libreadline-dev zlib1g-dev autoconf bison libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libsqlite3-dev && \
	echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd && \
	sh /home/coder/scripts/install-tools-nodejs.sh && \
	sh /home/coder/scripts/install-tools-php.sh "${TZ}" && \
	# Cleanup after install
	apt-get autoremove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=docker /usr/bin/docker /usr/local/bin/docker

RUN addgroup --gid ${PGID} coder && \
	adduser --uid ${PUID} --ingroup coder --home /home/coder --shell /bin/zsh --disabled-password --gecos "" coder && \
	USER=coder && \
	GROUP=coder

# Authorize SSH Host
RUN mkdir -p /home/coder/.ssh && \
	chmod 0700 /home/coder/.ssh && \
	ssh-keyscan github.com > /home/coder/.ssh/known_hosts

# Add the keys and set permissions
RUN echo "$ssh_prv_key" > /home/coder/.ssh/id_rsa && \
	echo "$ssh_pub_key" > /home/coder/.ssh/id_rsa.pub && \
	chmod 600 /home/coder/.ssh/id_rsa && \
	chmod 600 /home/coder/.ssh/id_rsa.pub && \
	chown -R coder:coder /home/coder
