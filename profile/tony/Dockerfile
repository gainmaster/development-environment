FROM bachelorthesis/development-environment:archlinux

RUN pacman-install zsh nano
RUN add-user tony /usr/bin/zsh

USER tony

WORKDIR /home/tony
ADD ./ ./
RUN \
  git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh && \
  rm Dockerfile && \
  chown tony:tony .zshrc && \
  chmod 644 .zshrc && \
  chown tony:tony .screenrc && \
  chmod 644 .screenrc && \
  chown tony:tony .gitconfig && \
  chmod 644 .gitconfig && \
  chown tony:tony .ssh && \
  chmod 700 .ssh && \
  chown tony:tony .ssh/authorized_keys