FROM bachelorthesis/archlinux

RUN pacman-install git curl wget sudo sqlite
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD add-user.sh /usr/bin/add-user