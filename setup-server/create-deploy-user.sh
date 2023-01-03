#!/bin/bash
echo "What's the name of this server?"
read servername
sudo sh -c "echo $servername > /etc/hostname"

sudo useradd --password U6aMy0wojraho --create-home --shell "/bin/bash" --user-group --groups "users,sudo" app
sudo passwd -d app
USER_HOME=/home/app
sudo -u "app" mkdir "$USER_HOME/.ssh"
sudo -u "app" touch "$USER_HOME/.ssh/authorized_keys"
sudo chmod 0600 "$USER_HOME/.ssh/authorized_keys"

echo "Deploy user app created successfully. Make sure to login as app user before continuing the installation."
echo "Server will restart in 3s"
sleep 3
echo "Restarting server"
sudo reboot