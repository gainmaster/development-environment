FROM bachelorthesis/development-environment:archlinux

RUN pacman-install zsh nano
RUN add-user tony /usr/bin/zsh

USER tony

WORKDIR /home/tony
ADD ./ ./
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
RUN rm Dockerfile