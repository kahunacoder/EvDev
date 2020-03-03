
FROM registry.kc.gs/code-tools:latest
ENV LANG=en_US.UTF-8
ENV PATH=/home/coder/.rbenv/bin::/home/coder/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

USER coder

COPY scripts /home/coder/scripts

# # Configure oh-my-zsh https://github.com/ohmyzsh/ohmyzsh/raw/master/tools/install.sh
RUN wget https://github.com/ohmyzsh/ohmyzsh/raw/master/tools/install.sh -O - | zsh || true
COPY --chown=coder:coder ./settings/zshrc /home/coder/.zshrc
COPY --chown=coder:coder ./settings/zshrc /home/coder/.aliases
COPY --chown=coder:coder ./settings/gitconfig /home/coder/.gitconfig
COPY --chown=coder:coder ./settings/tmux.conf /home/coder/.tmux.conf

RUN sh /home/coder/scripts/install-tools-rubyenv-gems.sh && \
	sh /home/coder/scripts/install-tools-composer-globals.sh && \
	sh /home/coder/scripts/install-tools-yarn-globals.sh

