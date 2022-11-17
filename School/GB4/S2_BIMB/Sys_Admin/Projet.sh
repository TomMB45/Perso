#!/bin/bash

volume="/media/$USER"
if mount|grep $volume;
then 
	#find /media/$USER -maxdepth 1 -mindepth 1 -type d #> ~/Documents/USB.txt;
	mount|grep "/dev/" #>> ~/Documents/USB.txt
	echo "Would you like to unmount the device ?"; 


	else echo "Any devices connected"
fi 

#Savoir quels périphériques sont monté : /media

#Bien aussi : lsblk | grep "part"

#Unmount systeme de fichier : umount /dev/sdb1 
#Monter un systeme de fichier : mount /dev/sdb1 /media/$USER/
#Pb obligé de sudo pour utiliser mount 
