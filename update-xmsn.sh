#! /bin/bash

#######################################################
# This script simply adds new .torrent files to a local 
# Transmission seeder.

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

seed='http://localhost:9091/transmission/rpc --auth=user:pass'

# Start a loop
for tfile in "$desk32tfile" "$desk64tfile" "$kde32tfile" "$kde64tfile" "$lxde32tfile" "$lxde64tfile" "$mate32tfile" "$mate64tfile" "$soas32tfile" "$soas64tfile" "$xfce32tfile" "$xfce64tfile";
	do transmission-remote $seed -a $alt_fed$tfile;
done
