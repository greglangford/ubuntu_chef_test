
#!/bin/bash

SSH_HOST=$1

if [ ! $SSH_HOST ];
then
  echo "USAGE ./bootstrap.sh <IP ADDRESS>"
  exit 1
fi

echo "Starting bootstrap ..."

ssh-keygen -R $SSH_HOST &> /dev/null

while [ true ]; do
  scp -o StrictHostKeyChecking=no -q -r . root@$SSH_HOST:/root/chef &> /dev/null

  if [ $? -eq 0 ];
  then
    break
  fi

  sleep 5
done

ssh -T root@$SSH_HOST << EOF
  curl -L https://omnitruck.chef.io/install.sh | sudo bash
  cd /root/chef
  chef-client -z --runlist "recipe[ufw],recipe[system::apt],recipe[system::reboot]"
EOF

echo "Waiting for server to come back online"
sleep 5

while [ true ]; do
  UPTIME=`ssh root@$SSH_HOST -C "uptime" 2> /dev/null`

  if [ $? -ne 0 ];
  then
    sleep 5
  else
    echo "SERVER UPTIME: $UPTIME"
    break
  fi
done
