# make it automaticly executed when system start.
sudo touch /etc/rc.local

sudo touch /etc/systemd/system/rc-local.service
sudo chmod +x /etc/rc.local

# get actual username not "root".
user=$(python3 get_user.py)

sudo echo "/home/$user/Downloads/StartScript.sh &" > /etc/rc.local

# to expand variables
sudo chmod +x settings.sh

# to run
sudo bash controller.sh
