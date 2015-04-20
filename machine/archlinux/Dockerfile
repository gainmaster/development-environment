FROM bachelorthesis/archlinux:base-devel

RUN pacman-install git vim wget sqlite openssh screen dnsutils
RUN aur-install ondir

RUN echo "Port 2200" >> /etc/ssh/sshd_config && systemctl enable sshd