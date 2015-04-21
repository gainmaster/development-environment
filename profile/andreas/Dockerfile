FROM gainmaster/development-machine:archlinux

RUN pacman-install zsh nano
RUN add-sudo-user andreas /usr/bin/zsh

USER andreas

WORKDIR /home/andreas
ADD ./ ./

RUN \
  git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh && \
  rm Dockerfile && \
  chown andreas:andreas .zshrc && \
  chmod 644 .zshrc && \
  chown andreas:andreas .screenrc && \
  chmod 644 .screenrc && \
  chown andreas:andreas .gitconfig && \
  chmod 644 .gitconfig && \
  chown andreas:andreas .ssh && \
  chmod 700 .ssh && \
  chown andreas:andreas .ondirrc && \
  chmod 644 .ondirrc && \
  chown andreas:andreas .ssh/authorized_keys