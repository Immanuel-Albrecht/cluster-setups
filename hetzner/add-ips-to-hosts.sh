#!/bin/sh

while read -r line ; do
	hostname=$(echo $line | awk '{ print $2 }')
	if ! [ -z "$hostname" ] ; then
		ipv4=$(echo $line | awk '{ print $4 }')
		ipv6=$(echo $line | awk '{ print $5 }')
		echo $hostname has ip $ipv4 and $ipv6
		sudo sed -i .bak "/[0-9.:a-fA-F/]*\s*$hostname\$/d" /etc/hosts
		echo "$ipv4	$hostname" | sudo sh -c 'cat >> /etc/hosts'
		echo "$ipv6	$hostname" | sudo sh -c 'cat >> /etc/hosts'

		echo "Fixing fingerprints, too."
		ssh-keygen -R "$hostname"
		ssh-keygen -R "$ipv4"
		ssh-keygen -R "$ipv6"

		ssh-keyscan -T 10 $hostname >> ~/.ssh/known_hosts

	fi

done <<< "$(hcloud server list | grep running)"
