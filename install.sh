#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")

GAINMASTER_PROFILE=$1
GAINMASTER_DIRECTORY=$(pwd)

GAINMASTER_SCRIPT_FILE=/usr/local/bin/gainmaster
#GAINMASTER_SCRIPT_FILE=./gainmaster

rm -f $GAINMASTER_SCRIPT_FILE
touch $GAINMASTER_SCRIPT_FILE
chmod +x $GAINMASTER_SCRIPT_FILE

echo '#!/usr/bin/env bash' >> $GAINMASTER_SCRIPT_FILE
echo "export GAINMASTER_PROFILE=${GAINMASTER_PROFILE}" >> $GAINMASTER_SCRIPT_FILE
echo "export GAINMASTER_DIRECTORY=${GAINMASTER_DIRECTORY}" >> $GAINMASTER_SCRIPT_FILE

cat << 'EOF' >> $GAINMASTER_SCRIPT_FILE

if [ -z "$1" ]; then 
    gainmaster login 
fi

case "$1" in
    coreos)
        stat=$(gainmaster status);
        if [ "$stat" == "Not unning" ]; then
            echo "CoreOS is not running"
        else
            cd $GAINMASTER_DIRECTORY
            vagrant ssh
        fi
        ;;

    login)
        gainmaster start
        ssh -p 2200 -A -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $GAINMASTER_PROFILE@127.0.0.1
        ;;
         
    destroy)
        cd $GAINMASTER_DIRECTORY
        vagrant destroy
        ;;

    stop)
        stat=$(gainmaster status);
        if [ "$stat" == "Running" ]; then
            cd $GAINMASTER_DIRECTORY
            vagrant halt
        fi
        gainmaster status
        ;;

    stop-force)
        stat=$(gainmaster status);
        if [ "$stat" == "Running" ]; then
            cd $GAINMASTER_DIRECTORY
            vagrant halt --force
        fi
        gainmaster status
        ;;

    status)
            cd $GAINMASTER_DIRECTORY
            stat=$(vagrant status 2>/dev/null | grep gainmaster-coreos | rev | cut -d'(' -f2 | cut -c2-8 | rev) 
            if [ "$stat" == "running" ]; then
                echo "Running"
                exit 0
            fi
            echo "Not running"
        ;;

    start)
        stat=$(gainmaster status);
        if [ "$stat" == "Not running" ]; then
            cd $GAINMASTER_DIRECTORY
            vagrant up
        fi
        ;;
esac