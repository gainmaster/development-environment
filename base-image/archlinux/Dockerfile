FROM bachelorthesis/archlinux

RUN pacman-install git curl wget sudo sqlite openssh screen dnsutils
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "Port 2200" >> /etc/ssh/sshd_config

RUN systemctl enable sshd

ADD add-user.sh /usr/bin/add-user

ADD ./ondir-0.2.2-3-x86_64.pkg.tar.xz /tmp/ondir-0.2.2-3-x86_64.pkg.tar.xz
RUN pacman -U /tmp/ondir-0.2.2-3-x86_64.pkg.tar.xz --noconfirm
RUN rm /tmp/ondir-0.2.2-3-x86_64.pkg.tar.xz
