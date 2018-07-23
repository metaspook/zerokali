#!/bin/sh
# ZeroKali
# Kali Linux Tweaker and Post Installation Script
# Version: 1.0
# Written by Metaspook
# Copyright (c) 2018 Metaspook.

### VARIABLES ###
TY=`tput setaf 3`
TYBD=`tput setaf 3; tput bold`
TS=`tput setaf 6`
TBD=`tput bold`
TD=`tput dim`
TRT=`tput sgr0`
TCR=`tput clear`

### FUNCTIONS ###
fnexit(){
case $1 in
-mkdir) echo "[FAIL!] Can't creat $2 directory."; exit ;;
-rmdir) echo "[FAIL!] Can't remove $2 directory."; exit ;;
-nozip) echo "[FAIL!] Please input a valid OTA/ROM zip file."; exit ;;
-nopython) echo "[FAIL!] Python isn't installed."; exit ;;
-nobb) echo "[FAIL!] Busybox not found."; exit ;;
-nosrcdir) echo "[FAIL!] No Source or Target directory exists."; exit ;;
-nosrcfile) echo "[FAIL!] No Source or Target file exists."; exit ;;
-noin) echo "[FAIL!] No or Invalid input detected."; exit ;;
-nosrc) echo "[FAIL!] No Source or Target exists."; exit ;;
-noors) echo -e "[FAIL!] OpenRecoveryScript not found.\n"; exit ;;
-noroot) echo -e "[FAIL!] ${0##*/} should run by root user.\n"; exit ;;
esac
}
chkroot(){
# Checking Root Access.
id=$(id); id=${id#*=}; id=${id%%[\( ]*}
[ "$id" = "0" ] || [ "$id" = "root" ] && ROOT=true
[ ! "$ROOT" ] && fnexit -noroot
}
fnbanner(){
clear; echo "
$TYBD
$TS __________                  $TY ____  __.      .__  .__ 
$TS \____    /___________  ____ $TY|    |/ _|____  |  | |__|
$TS   /     // __ \_  __ \/  _ \\$TY|      < \__  \ |  | |  |
$TS  /     /\  ___/|  | \(  <_> $TY)    |  \ / __ \|  |_|  |
$TS /_______ \___  >__|   \____/$TY|____|__ (____  /____/__|
$TS         \/   \/             $TY     \/    \/         $TRT
$TD  Kali Linux Tweaker                     Version: 1.0
  by Metaspook $TRT
"
}
fnaptcleaner(){
killall apt-get
rm /var/lib/apt/lists/lock
rm /var/cache/apt/archives/lock
rm /var/lib/dpkg/lock
dpkg --configure -a
apt-get clean
fnbanner
echo "[DONE] apt-get Clean/Fixed"
sleep 3
}
fnupdatekali(){
apt-get clean || fnaptcleaner
apt-get update
apt-get upgrade -y 1>/dev/null
apt-get install linux-headers-$(uname -r)
apt-get dist-upgrade &>/dev/null
apt-get autoremove
fnbanner
echo "[DONE] Kali Linux updated."
sleep 3
}
fninfokali(){
echo -n "
 +--------------------+  
 | System Information | 
 +--------------------+ 
 | Distributor ID: $(lsb_release -is)
 | Description   : $(lsb_release -ds)
 | Release       : $(lsb_release -rs)
 | Codename      : $(lsb_release -cs)
 | Processor Type: $(uname -m)
 | Kernal Version: $(uname -r)
  \\
   ..Press Enter to Main Manu.."
read -r coin00
case $coin00 in
*) fnbanner; fnzkusage;;
esac
}
fnvmtools(){
if [ "`ls /media/cdrom0 | grep VMware`" ]; then
cp /media/cdrom0/* /tmp && cd /tmp && tar xvf /tmp/VMwareTools*
cd vmware-tools-distrib
./vmware-install.pl –default
vmware-toolbox-cmd upgrade status
rm -rf /tmp/vmware*
rm -rf /tmp/VMware*
elif [ "`ls /media/cdrom0 | grep VBox`" ]; then
sh /media/cdrom0/VBoxLinuxAdditions.run
elif [ "`dmidecode | grep VMware`" ]; then
apt-get install open-vm-tools
elif [ "`dmidecode | grep VirtualBox`" ]; then
apt-get install virtualbox-guest-additions-iso
fi
fnbanner
echo "[DONE] VBox/VM Tools installed."
sleep 3
}
fnkalitweaks(){
fnbanner
echo "[!] Underconstruction :("
sleep 3
}

fnzkusage(){
fnbanner
echo -n "
 1. Update Kali.
 2. System Info.
 3. Kali Tweaks
 4. apt-get Cleaner/Fixer.
 5. VBox/VM Tools.
 0. Exit
 
Enter Option: "
read -r coin00
case $coin00 in
1) fnbanner; fnupdatekali; fnzkusage;;
2) fnbanner; fninfokali; fnzkusage;;
3) fnkalitweaks; fnzkusage;;
4) fnbanner; fnaptcleaner 2>/dev/null; fnzkusage;;
5) fnbanner; fnvmtools; fnzkusage;;
0) clear; exit 0;;
*) fnzkusage;;
esac
}

#
#----< CALL CENTER >----#
#
chkroot
case ${0##*/} in
zerokali|zerokali.sh)
	allarg="$*"
	case $1 in
	audmod) fnaudmod ${allarg#$1 };;
	gethal) ;; #placeholder
	sethal) ;; #placeholder
	*) fnzkusage;;
	esac
	;;
audmod) fnaudmod ${*};;
gethal) ;; #placeholder
sethal) ;; #placeholder
esac

#unset ORSDIR ORS
#unalias -a
exit 0

sleep 2

echo " "
echo " ------------------------- "
echo "| Updating overall System |"
echo " ------------------------- "
echo "Engine Initializing..."





while true;do echo -n .;sleep 1;done &
apt-get update 1>/dev/null
kill $!; trap 'kill $!' SIGTERM
echo "Done"
sleep 200
echo " "
echo " -------------------------------- "
echo "| Recheck current System version |"
echo " -------------------------------- "
lsb_release -i;lsb_release -r;lsb_release -d;lsb_release -c
printf "Kernal Version: ";uname -r
printf "Processor Type: ";uname -m
echo " "
echo " -------------------------- "
echo "| Updating Audio utilities |"
echo " -------------------------- "
apt-get install alsa-utils -y
echo " "
echo "[DONE] All post installation jobs."
echo " "
