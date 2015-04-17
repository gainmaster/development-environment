FROM bachelorthesis/development-environment:archlinux

RUN pacman-install zsh nano
RUN add-user knut /usr/bin/zsh

USER knut

WORKDIR /home/knut
COPY ./ ./

RUN \
  git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh && \
  rm Dockerfile && \
  chown knut:knut .zshrc && \
  chmod 644 .zshrc && \
  chown knut:knut .screenrc && \
  chmod 644 .screenrc && \
  chown knut:knut .gitconfig && \
  chmod 644 .gitconfig && \
  chown knut:knut .ssh && \
  chmod 700 .ssh && \
  chown knut:knut .ssh/authorized_keys && \
  chown knut:knut .ondirrc && \
  chmod 644 .ondirrc