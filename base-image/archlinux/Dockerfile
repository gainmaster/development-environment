FROM bachelorthesis/archlinux

RUN pacman-install git curl wget sudo sqlite openssh
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "Port 2200" >> /etc/sudoers

ADD add-user.sh /usr/bin/add-user