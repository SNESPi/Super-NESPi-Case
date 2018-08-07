
#Step 1) Check if root--------------------------------------
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root."
   exit 1
fi

#Step 2) Download Python script-----------------------------
cd /opt/
sudo mkdir SuperNESPi
cd SuperNESPi

script=softshutdown.py

if [ -e $script ];
	then
		echo "Script softshutdown.py already exists. Doing nothing."
	else
		wget "https://raw.githubusercontent.com/DeikiChen/softpower/master/softshutdown.py"
fi

#Step 4) Set sutostart ---------------------------
cd /etc/
RC=rc.local

if grep -q "sudo python \/opt\/SuperNESPi\/softshutdown.py \&" "$RC";

	then
		echo "File /etc/rc.local already configured. Doing nothing."
	else
		sed -i -e "s/^exit 0/sudo python \/opt\/SuperNESPi\/softshutdown.py \&\n&/g" "$RC"
		echo "File /etc/rc.local configured."
fi
#-----------------------------------------------------------

#-------------------------------------------------------------
#Step 5) Reboot to apply changes----------------------------
echo "SuperNESPi Case installation done. Will now reboot after 3 seconds."
sleep 3
sudo reboot
#-----------------------------------------------------------



