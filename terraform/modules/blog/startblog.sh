sudo yum update -y
sudo yum install -y git
# ssh-keygen -t rsa -b 4096  -N '' -C ${LOGNAME}@$HOSTNAME
echo ssh-keygen -t rsa -b 4096  -N '' -C ${LOGNAME}@$HOSTNAME
echo ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts
echo git clone git@github.com:RIMikeC/blog --recursive

