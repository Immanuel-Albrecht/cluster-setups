#!/bin/bash
# First parameter: number of minions

cd $(dirname $0)

echo Please unlock sudo!
echo Thanks! | sudo cat


MINIONS="dave stuart jerry jorge tim mark phil kevin bob jon"

if ! [ -z "$1" ] ; then
COUNT="$1"
else
COUNT=4
fi

./create-mini-server.sh # creates gru

IDX="$COUNT"

for name in $MINIONS ; do
  if [ $IDX -gt 0 ] ; then
	./create-micro-server.sh $name
	IDX=$((IDX - 1))
  fi
done

sleep 5

./add-ips-to-hosts.sh

./run-payloads.sh gru 'payloads/kubernetes-master.sh'

IDX="$COUNT"

for name in $MINIONS ; do
  if [ $IDX -gt 0 ] ; then
	./run-payloads.sh $name 'payloads/kubernetes-minion.sh'
	IDX=$((IDX - 1))
  fi
done

echo -n "Waiting for master"

while true ; do
	if ! [ -z $(ssh root@gru /bin/bash -c "'if [ -f ~/master-is-setup ] ; then echo CONTINUE ; fi'" ) ] ; then
		break	
	fi
	sleep 5
	echo -n "."
done

echo "."

IDX="$COUNT"

for name in $MINIONS ; do
  if [ $IDX -gt 0 ] ; then
	echo -n "Waiting for $name"

	while true ; do
		if ! [ -z $(ssh "root@$name" /bin/bash -c "' if [ -f ~/minion-waiting-to-join ] ; then echo CONTINUE ; fi'" ) ] ; then
			break	
		fi
		sleep 5
		echo -n "."
	done
	echo "."
	IDX=$((IDX - 1))

  fi
done

./let-minions-join-gru.sh

./copy-config.sh gru

./dashboard-token.sh gru | pbcopy

echo "Copied dashboard token to pasteboard."

