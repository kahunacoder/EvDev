# Just use the code-server docker binary
FROM codercom/code-server as coder-binary

FROM ubuntu:18.04 as vscode-env
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl && \
	curl -o vscode-amd64.deb -L https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable && \
	dpkg -i vscode-amd64.deb || true && \
	apt-get install -y -f && \
	rm -f vscode-amd64.deb && \
	# # VSCode missing deps
	apt-get install -y libx11-xcb1 libasound2 && \
	# CLI json parser
	apt-get install -y jq

RUN addgroup --gid 1000 coder && \
	adduser --uid 1000 --ingroup coder --home /home/coder --shell /bin/zsh --disabled-password --gecos "" coder && \
	USER=coder && \
	GROUP=coder

USER coder
COPY scripts /home/coder/scripts
COPY sync.gist /home/coder/sync.gist

RUN	mkdir -p /home/coder/.local/share/code-server/logs

# This gets user config from gist, parse it and install exts with VSCode
RUN code -v --user-data-dir /home/coder/.local/share/code-server && \
	cd /home/coder/scripts && \
	sh get-config-from-gist.sh && \
	sh parse-extension-list.sh && \
	sh install-vscode-extensions.sh ../extensions.list && \
	mv ../.vscode/extensions ../.local/share/code-server/extensions && \
	mv ../settings.json ../.local/share/code-server/User/settings.json

# sh mv  && \

# The production image for code-server
FROM ubuntu:18.04

ENV PATH=/home/coder/.rbenv/bin:/home/coder/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY fonts /usr/share/fonts/truetype

RUN addgroup --gid 1000 coder && \
	adduser --uid 1000 --ingroup coder --home /home/coder --shell /bin/zsh --disabled-password --gecos "" coder && \
	USER=coder && \
	GROUP=coder

#  apt-utils net-tools git locales dumb-init curl wget unzip zsh apt-transport-https ca-certificates gnupg2 software-properties-common
RUN apt-get update && \
	apt-get install -y curl gnupg2 ca-certificates git zsh wget unzip powerline fonts-powerline zsh-theme-powerlevel9k zsh-syntax-highlighting ansible && \
	apt-get install -y locales && \
	locale-gen en_US.UTF-8 && \
	apt-get autoremove && \
	apt-get clean

# Install langauge toolchains
COPY scripts /home/coder/scripts
RUN sh /home/coder/scripts/install-tools-dev.sh
RUN sh /home/coder/scripts/install-tools-python.sh
RUN sh /home/coder/scripts/install-tools-nodejs.sh
RUN sh /home/coder/scripts/install-tools-ruby.sh
RUN sh /home/coder/scripts/install-tools-php.sh

# RUN sh /tmp/scripts/install-tools-golang.sh
# RUN sh /tmp/scripts/install-tools-cpp.sh

# RUN fc-cache -f -v

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

############################# from here when can run as user #############################

USER coder

COPY --from=coder-binary --chown=coder:coder /usr/local/bin/code-server /home/coder/.local/bin/code-server
COPY --from=vscode-env --chown=coder:coder /home/coder/.local/share/code-server /home/coder/.local/share/code-server
# COPY --from=vscode-env --chown=coder:coder /home/coder/settings.json /home/coder/.local/share/code-server/User/settings.json
# COPY --from=vscode-env --chown=coder:coder /home/coder/.vscode/extensions /home/coder/.local/share/code-server/extensions


# Locale Generation
# We unfortunately cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LANG=en_US.UTF-8

# Configure oh-my-zsh https://github.com/ohmyzsh/ohmyzsh/raw/master/tools/install.sh
RUN wget https://github.com/ohmyzsh/ohmyzsh/raw/master/tools/install.sh -O - | zsh || true
COPY --chown=coder:coder ./settings/zshrc /home/coder/.zshrc
COPY --chown=coder:coder ./settings/zshrc /home/coder/.aliases

RUN sh /home/coder/scripts/install-tools-rubyenv-gems.sh
RUN sh /home/coder/scripts/install-tools-composer-globals.sh
RUN sh /home/coder/scripts/install-tools-yarn-globals.sh

EXPOSE 8080
VOLUME [ "/home/coder/projects" ]
VOLUME ["/home/coder/.local/share/code-server"]
WORKDIR /home/coder/projects

# ENTRYPOINT ["code-server", "--user-data-dir", "/home/coder/.local/share/code-server"]
CMD code-server
