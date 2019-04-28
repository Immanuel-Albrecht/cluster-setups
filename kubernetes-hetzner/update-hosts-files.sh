#!/bin/bash

cd $(dirname $0)

set -x

echo "Updating the hosts files on all Hetzner servers found..."

for host in `./hcloud.sh server list | grep running | awk '{ print $2 }'` ; do

	echo "Uploading setup script to $host..."

	while true ; do

		if ( cat <<EOF
#!/bin/bash

while read -r line ; do
	hostname=\$(echo \$line | awk '{ print \$2 }')
	if ! [ -z "\$hostname" ] ; then
		ipv4=\$(echo \$line | awk '{ print \$4 }')
		ipv6=\$(echo \$line | awk '{ print \$5 }')
		echo \$hostname has ip \$ipv4 and \$ipv6
		sed -i.bak "/[0-9.:a-fA-F/]*\s*\$hostname\\\$/d" /etc/hosts
		echo "\$ipv4	\$hostname" | cat >> /etc/hosts
		echo "\$ipv6	\$hostname" | cat >> /etc/hosts
	fi
done <<< "\$(cat server-list)"
EOF
		) | ssh "root@$host" 'cat > update-hosts.sh' ; then
			break
		fi

		echo "retrying in 15 seconds..."
		sleep 15

	done

	echo "Uploading current server list $host..."

	while true ; do

		if ./hcloud.sh server list | grep running | ssh "root@$host" 'cat > server-list'  ; then
			break
		fi

		echo "retrying in 15 seconds..."
		sleep 15

	done

	echo "Chmod +x-ing on $host"
	
	while true ; do

		if ssh "root@$host" 'chmod +x update-hosts.sh'  ; then
			break
		fi

		echo "retrying in 15 seconds..."
		sleep 15

	done

	echo "Running the update script on $host..."
	
	while true ; do

		if ssh "root@$host" 'tmux new-session -d -s updhosts ./update-hosts.sh'  ; then
			break
		fi

		echo "retrying in 15 seconds..."
		sleep 15

	done

done
