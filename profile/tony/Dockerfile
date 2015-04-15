FROM bachelorthesis/development-environment:archlinux

RUN pacman-install zsh nano
RUN add-user tony /usr/bin/zsh

USER tony

WORKDIR /home/tony
ADD ./ ./
RUN \
  git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh && \
  rm Dockerfile && \
  chown tony:tony .oh-my-zsh && \
  chmod 644 .oh-my-zsh && \
  chmod 644 .gitconfig && \
  chown tony:tony .ssh && \
  chmod 700 .ssh && \
  chown tony:tony .ssh/authorized_keys