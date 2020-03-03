FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive
ENV PUID=1001
ENV PGID=1001

RUN apt-get update && apt-get install -y curl && \
	curl -o vscode-amd64.deb -L https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable && \
	dpkg -i vscode-amd64.deb || true && \
	apt-get install -y -f && \
	rm -f vscode-amd64.deb && \
	# # VSCode missing deps
	apt-get install -y libx11-xcb1 libasound2 && \
	# CLI json parser
	apt-get install -y jq

RUN addgroup --gid ${PGID} coder && \
	adduser --uid ${PUID} --ingroup coder --home /home/coder --shell /bin/zsh --disabled-password --gecos "" coder && \
	USER=coder && \
	GROUP=coder

USER coder
COPY scripts /home/coder/scripts
COPY sync.gist /home/coder/sync.gist

# This gets user config from gist, parse it and install exts with VSCode
RUN code -v --user-data-dir /home/coder/.local/share/code-server && \
	cd /home/coder/scripts && \
	sh get-config-from-gist.sh && \
	sh parse-extension-list.sh && \
	sh install-vscode-extensions.sh ../extensions.list && \
	mv ../.vscode/extensions ../.local/share/code-server/extensions && \
	mv ../settings.json ../.local/share/code-server/User/settings.json

