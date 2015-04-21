FROM gainmaster/archlinux:base-devel

RUN pacman-install git vim wget sqlite openssh screen dnsutils
RUN aur-install ondir

RUN echo "Port 2200" >> /etc/ssh/sshd_config && systemctl enable sshd

COPY profile.d-gainmaster.sh /etc/profile.d/gainamster.sh
COPY profile.d-ondir.sh      /etc/profile.d/ondir.sh