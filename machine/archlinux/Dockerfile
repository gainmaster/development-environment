FROM bachelorthesis/archlinux:base-devel

RUN pacman-install git vim wget sqlite openssh screen dnsutils

RUN echo "Port 2200" >> /etc/ssh/sshd_config
RUN systemctl enable sshd