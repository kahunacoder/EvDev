# Just use the code-server docker binary
FROM codercom/code-server as coder-binary

FROM ubuntu:18.04 as vscode-env
ARG DEBIAN_FRONTEND=noninteractive
COPY fonts /root/.local/share/fonts
RUN fc-cache -f -v

RUN apt-get update && apt-get install -y curl && \
	curl -o vscode-amd64.deb -L https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable && \
	dpkg -i vscode-amd64.deb || true && \
	apt-get install -y -f && \
	rm -f vscode-amd64.deb && \
	# # VSCode missing deps
	apt-get install -y libx11-xcb1 libasound2 && \
	# CLI json parser
	apt-get install -y jq
# apt-get autoremove && \
# apt-get clean

COPY scripts /root/scripts
COPY sync.gist /root/sync.gist

# This gets user config from gist, parse it and install exts with VSCode
RUN code -v --user-data-dir /root/.config/Code && \
	cd /root/scripts && \
	sh get-config-from-gist.sh && \
	sh parse-extension-list.sh && \
	sh install-vscode-extensions.sh ../extensions.list

# The production image for code-server
FROM ubuntu:18.04

ENV PATH=/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#  apt-utils net-tools git locales dumb-init curl wget unzip zsh apt-transport-https ca-certificates gnupg2 software-properties-common
COPY fonts /root/.local/share/fonts
RUN fc-cache -f -v

RUN apt-get update && \
	apt-get install -y curl gnupg2 ca-certificates git zsh wget unzip fontconfig default-jre powerline fonts-powerline zsh-theme-powerlevel9k zsh-syntax-highlighting ansible && \
	apt-get install -y locales && \
	locale-gen en_US.UTF-8 && \
	apt-get autoremove && \
	apt-get clean

COPY fonts /usr/local/share/fonts
RUN fc-cache -f -v
\

COPY --from=coder-binary /usr/local/bin/code-server /root/.local/bin/code-server
COPY scripts /root/scripts
COPY --from=vscode-env /root/settings.json /root/.local/share/code-server/User/settings.json
COPY --from=vscode-env /root/.vscode/extensions /root/.local/share/code-server/extensions

# Install langauge toolchains
RUN sh /root/scripts/install-tools-ruby.sh
RUN sh /root/scripts/install-tools-php.sh
RUN sh /root/scripts/install-tools-nodejs.sh
RUN sh /root/scripts/install-tools-dev.sh
RUN sh /root/scripts/install-tools-python.sh
# RUN sh /root/scripts/install-tools-golang.sh
# RUN sh /root/scripts/install-tools-cpp.sh

## cleanup of files from setup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Locale Generation
# We unfortunately cannot use update-locale because docker will not use the env variables
# configured in /etc/default/locale so we need to set it manually.
ENV LANG=en_US.UTF-8

RUN chsh -s /usr/bin/zsh root

# Configure oh-my-zsh https://github.com/ohmyzsh/ohmyzsh/raw/master/tools/install.sh
RUN wget https://github.com/ohmyzsh/ohmyzsh/raw/master/tools/install.sh -O - | zsh || true
COPY ./config/zshrc /root/.zshrc
COPY ./config/aliases /root/.aliases

EXPOSE 8080
VOLUME [ "/project" ]
WORKDIR /project

CMD code-server $PWD
# ENTRYPOINT ["dumb-init", "fixuid","code-server"]