#!/usr/bin/env bash

#!/usr/bin/env bash

username="$1"
shell="$2"

if [[ -z $(which sudo) ]]; then
    echo "Installing sudo"
    pacman-install sudo
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

useradd -G wheel -s $shell -U $username && passwd -d $username
mkdir /home/$username
chown $username:$username /home/$username 
chmod 750 /home/$username