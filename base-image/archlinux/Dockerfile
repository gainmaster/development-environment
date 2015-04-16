FROM bachelorthesis/archlinux

RUN pacman-install git curl wget sudo sqlite openssh screen dnsutils vim base-devel
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "Port 2200" >> /etc/ssh/sshd_config

RUN systemctl enable sshd

ADD add-user.sh /usr/bin/add-user
ADD ondir /usr/bin/ondir
