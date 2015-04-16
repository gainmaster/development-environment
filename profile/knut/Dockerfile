FROM bachelorthesis/development-environment:archlinux

RUN pacman-install nano
RUN add-user knut

USER knut

WORKDIR /home/knut
ADD ./ ./
RUN \
  rm Dockerfile && \
  chown knut:knut .screenrc && \
  chmod 644 .screenrc && \
  chown knut:knut .gitconfig && \
  chmod 644 .gitconfig && \
  chown knut:knut .ssh && \
  chmod 700 .ssh && \
  chown knut:knut .ssh/authorized_keys