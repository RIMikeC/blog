#!/bin/bash
yum update -y
yum install -y git
mkdir ~/.ssh
ssh-keygen -t rsa -b 4096  -N '' -C ${LOGNAME}@$HOSTNAME -f ~/.ssh/id_rsa
ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts
mkdir ~/blog
cd ~/blog
# At this point we need to get the SSH key into Github
# then we can execute -
#      git clone git@github.com:RIMikeC/blog --recursive

