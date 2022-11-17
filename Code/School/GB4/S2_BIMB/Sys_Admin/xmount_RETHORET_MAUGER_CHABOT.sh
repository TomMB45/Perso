#!/bin/bash

##### OPTIONS #####
Help()
{
   # Display Help
   echo "Help for xmount"
   echo "This application is as simple as it gets, once launced you just have to select the device(s) you want to mount or unmount. You also have the option to mount all devices or unmount all devices registered in you fstab file."
   echo "Be sure that your devices have the right flags, conflict can arise for user permission or auto mount if not specified."
   echo
}

Info()
{
   # Display info
   echo "Mount manager developped by M. RETHORET-PASTY, T. MAUGER-BIROCHEAU and A. CHABOT
as part of the System & Network Administration course of Pr. G. BERNOT at Polytech' Nice Sophia, France"
}


while getopts ":hi" option; do 
   case $option in
      h) # display Help
         Help
         exit;;
      i) # display Info
         Info
         exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

##### MAIN #####
if [ -f /tmp/xmountlogs.txt ]; then #Clear logs that might already exist
    rm /tmp/xmountlogs.txt
fi

# Fetching devices that are or can be mounted according to fstab and user rights.
case $USER in
    root)
        mnt=$(findmnt --fstab --evaluate -o source,options,target 2>> /tmp/xmountlogs.txt | egrep -vw "none|/|/home|/boot/efi" | awk '$1 ~ /^\/dev/ {print $1}') # if root
    ;;
    *)
        mnt=$(findmnt --fstab --evaluate -o source,options 2>> /tmp/xmountlogs.txt | grep user | awk '$1 ~ /^\/dev/ {print $1}') # if user
    ;;
esac

choix=() #Array for zenity
for c in $mnt; do
    if cat /proc/mounts | awk '{print $1}' | grep -qs $c; then #check if mounted    
        ismnt=Unmount
    else
        ismnt=Mount
    fi
    choix+=(FALSE "$c" "$ismnt") # Generating Row for Zenity
done

# Zenity List for user entry
liste=$(zenity --list --checklist \
  --title="Xmount" \
  --print-column=2 --separator=" "\
  --column="Mount" --column="Device" --column="Action" \
    "${choix[@]}" \ FALSE ⇩ MountAll \ FALSE ⇫ UnmountAll )
   
    
# Handling result of choices
for i in $liste; do
    case $i in
        MountAll)
            mount -a 2>> /tmp/xmountlogs.txt # Mount all devices in fstab if not mounted
            zenity --info \
            --text="Everything that could be mounted is mounted"
        ;;
        UnmountAll)
            for w in $mnt; do
                if cat /proc/mounts | awk '{print $1}' | grep -qs $w; then
                    umount $w 2>> /tmp/xmountlogs.txt #Unmounting all devices that can be unmounted
                fi
            done

            zenity --info \
            --text="Everything that could be unmounted is unmounted"
        ;;
        *)
            if cat /proc/mounts | awk '{print $1}' | grep -qs $i; then
                umount $i 2>> /tmp/xmountlogs.txt # Unmounting a device
            else
                mount $i 2>> /tmp/xmountlogs.txt # Mounting a device
            fi
            zenity --info \
            --text="Everything has been updated"
        ;;
    esac
done
if [ -s /tmp/xmountlogs.txt ]; then # Handling errors
    zenity --error --text="`cat /tmp/xmountlogs.txt`"
fi
exit                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
