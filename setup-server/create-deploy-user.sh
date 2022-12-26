sudo useradd --p U6aMy0wojraho --create-home --shell "/bin/bash" --user-group --groups "users,sudo" app
sudo passwd -d app
USER_HOME=/home/app
sudo -u "app" mkdir "$USER_HOME/.ssh"
sudo -u "app" touch "$USER_HOME/.ssh/authorized_keys"
sudo chmod 0600 "$USER_HOME/.ssh/authorized_keys"
sudo su app
cd ~