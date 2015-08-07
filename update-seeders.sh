#! /bin/bash

#######################################################
# This is intended to be tacked on to the end of the 
# tracker updater script. All variables are declared 
# here to run as a stand-alone, however. To add to the
# main script, remove these variables as they are already
# declared.

alt_fed='http://alt.fedoraproject.org/pub/alt/live-respins/'
release=$(curl ${alt_fed} |awk '{print $6}'|awk '{print substr($0,7,3)}'|sed '15q;d') &> /dev/null
updated=$(curl ${alt_fed}|awk '{print $7}'|sed '15q;d'|sed -e 's/-//g') &> /dev/null

# Torrent variables
desk32tfile="$release-i686-DESK-$updated.torrent"
desk64tfile="$release-x86_64-DESK-$updated.torrent"
kde32tfile="$release-i686-KDE-$updated.torrent"
kde64tfile="$release-x86_64-KDE-$updated.torrent"
lxde32tfile="$release-i686-LXDE-$updated.torrent"
lxde64tfile="$release-x86_64-LXDE-$updated.torrent"
mate32tfile="$release-i686-MATE-$updated.torrent"
mate64tfile="$release-x86_64-MATE-$updated.torrent"
soas32tfile="$release-i686-SOAS-$updated.torrent"
soas64tfile="$release-x86_64-SOAS-$updated.torrent"
xfce32tfile="$release-i686-XFCE-$updated.torrent"
xfce64tfile="$release-x86_64-XFCE-$updated.torrent"

# The seeder urls
seeder_1='http://seeder1.url/transmission/rpc --auth=user:pass'
seeder_2='http://seeder2.url/transmission/rpm --auth=user:pass'
seeder_3='http://seeder3.url/transmission/rpm --auth=user:pass'
seeder_4='http://seeder4.url/transmission/rpm --auth=user:pass'

# Here we go...
echo "Populating the seeders..."

# Start a loop
for seed in '$seeder_1 $seeder_2 $seeder_3 $seeder_4'; do
	echo 'Updating $seed'
	transmission-remote $seed -R
	for tfile in '$desk32tfile $desk64tfile $kde32tfile $kde64tfile $lxde32tfile $lxde64tfile $mate32tfile $mate64tfile $soas32tfile $soas64tfile $xfce32tfile $xfce64tfile'; do
		transmission-remote $seed -a $alt_fed$tfile
	done
done
