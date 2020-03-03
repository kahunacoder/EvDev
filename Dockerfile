# Just use the code-server docker binary
FROM codercom/code-server as coder-binary

FROM registry.kc.gs/vscode:latest as vscode-env

FROM registry.kc.gs/code-apps:latest
USER coder

COPY --from=coder-binary --chown=coder:coder /usr/local/bin/code-server /home/coder/.local/bin/code-server
COPY --from=vscode-env --chown=coder:coder /home/coder/.local/share/code-server /home/coder/.local/share/code-server
EXPOSE 8080
VOLUME ["/home/coder/.local/share/code-server"]
VOLUME [ "/home/coder/projects" ]
WORKDIR /home/coder/projects

CMD code-server
