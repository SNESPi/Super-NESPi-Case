#!/bin/bash
#Step 1 make /boot writable---------------------------------
sleep 2s

mount -o remount, rw /boot
mount -o remount, rw /

#-----------------------------------------------------------

#Step 2) Download Python script-----------------------------
mkdir /opt/snespi
sleep 2s

script=/opt/snespi/SafeShutdown.py

if [ -e $script ];
	then
		echo "Script SafeShutdown.py already exists. Doing nothing."
	else
		wget --no-check-certificate -O  $script "https://raw.githubusercontent.com/SNESPi/Super-NESPi-Case/master/recalbox_SafeShutdown.py"
fi
#-----------------------------------------------------------

sleep 2s

#Step 3) Enable Python script to run on start up------------
DIR=/etc/init.d/S99SNESPi

if grep -q "python $script &" "S99SNESPi";
	then
		if [ -x $DIR];
			then
				echo "Executable S99SNESPi already configured. Doing nothing."
			else
				chmod +x $DIR
		fi
	else
		echo "python $script &" >> $DIR
		chmod +x $DIR
		echo "Executable S99SNESPi configured."
fi
#-----------------------------------------------------------

#Step 4) Reboot to apply changes----------------------------
File=/boot/config.txt
if grep -q "avoid_warnings=1" "$File";
	then
		echo "WARN has disbales. Doing nothing."
	else
		echo "avoid_warnings=1" >> $File
		echo "WARN disbales"
fi

sleep 1s
echo "Super NESPi Case Switch installation done. Will now reboot after 3 seconds."
sleep 3
shutdown -r now
#-----------------------------------------------------------
