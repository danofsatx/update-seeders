#! /bin/bash

#######################################################
# This script is just to download the updated Live ISOs
# from dl.fp.o/alt. It is currently designed to D/L all
# of the ISOs in parallel, but it gives zero progress
# reports (that's a TODO). It will also grab the 
# .torrent files in order to populate a local seeder.

# Set this line according to your local configuration -
# this is where the ISO and .torrent files will go.
destDir="/home/torrents/"

alt_fed='http://alt.fedoraproject.org/pub/alt/live-respins/'
#release=$(curl ${alt_fed} |awk '{print $6}'|awk '{print substr($0,7,3)}'|sed '15q;d') &> /dev/null
#updated=$(curl ${alt_fed}|awk '{print $7}'|sed '15q;d'|sed -e 's/-//g') &> /dev/null
release="F22"
updated="20150912"

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

# ISO  variables
desk32ifile="$release-i686-DESK-$updated.iso"
desk64ifile="$release-x86_64-DESK-$updated.iso"
kde32tiile="$release-i686-KDE-$updated.iso"
kde64tiile="$release-x86_64-KDE-$updated.iso"
lxde32ifile="$release-i686-LXDE-$updated.iso"
lxde64ifile="$release-x86_64-LXDE-$updated.iso"
mate32ifile="$release-i686-MATE-$updated.iso"
mate64ifile="$release-x86_64-MATE-$updated.iso"
soas32ifile="$release-i686-SOAS-$updated.iso"
soas64ifile="$release-x86_64-SOAS-$updated.iso"
xfce32ifile="$release-i686-XFCE-$updated.iso"
xfce64ifile="$release-x86_64-XFCE-$updated.iso"

# Here we go...
echo "Downloading ISOs...."

ISO="$desk32ifile $desk64ifile $kde32tiile $kde64tiile $lxde32ifile $lxde64ifile $mate32ifile $mate64ifile $soas32ifile $soas64ifile $xfce32ifile $xfce64ifile"

# this line is what turns the threading on, -m is default off in bash
set -m

# This is the loop that gets threaded
for i in $ISO; 
        do wget --quiet $alt_fed$i -P $destDir &
done

# And this is the line that splits it all up for threading.
while [ 1 ]; do fg 2> /dev/null; [ $? == 1 ] && break; done

for i in $ISO;
        do chown transmission:transmission $destDir$i 
done

# Start a loop
for tfile in "$desk32tfile" "$desk64tfile" "$kde32tfile" "$kde64tfile" "$lxde32tfile" "$lxde64tfile" "$mate32tfile" "$mate64tfile" "$soas32tfile" "$soas64tfile" "$xfce32tfile" "$xfce64tfile";
	do wget --quiet $alt_fed$tfile -P $destDir
done
