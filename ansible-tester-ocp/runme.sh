#!/bin/bash
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < ${HOME}/passwd.template > /tmp/passwd
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/etc/group

echo -n "Running as: "
whoami
echo "GIT_URL: $GIT_URL" 
echo "PLAYBOOK: $PLAYBOOK" 
cd /opt/app-root
git clone $GIT_URL playbooks
ansible-playbook playbooks/$PLAYBOOK --syntax-check
ansible-playbook playbooks/$PLAYBOOK
