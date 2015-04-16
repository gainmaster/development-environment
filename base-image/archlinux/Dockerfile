FROM bachelorthesis/archlinux

RUN pacman-install git curl wget sudo sqlite openssh screen dnsutils
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "Port 2200" >> /etc/ssh/sshd_config

RUN systemctl enable sshd

ADD add-user.sh /usr/bin/add-user