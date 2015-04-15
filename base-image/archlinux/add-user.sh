#!/usr/bin/env bash

#!/usr/bin/env bash

username="$1"
shell="$2"

useradd -G wheel -s $shell -U $username && passwd -d $username
mkdir /home/$username
chown $username:$username /home/$username 
chmod 755 /home/$username