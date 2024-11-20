#!/bin/bash

cat /etc/hosts | while read -r line; do
	if [[ "$line" == "" || "$line" == \#* ]]; then
		continue
	fi

ip=$(echo "$line" | cut -d ' ' -f 1)
name=$(echo "$line" | cut -d ' ' -f 2)

resolved_ip=$(nslookup "$name" 2>/dev/null | grep 'Address:' | tail -n 1 | awk '{print $2}')

if [[ "$resolved_ip" != "$ip" &&  "$resolved_ip" != "" ]]; then
	echo "Bogus IP for $name in /etc/hosts! Expected: $ip, Got: $resolved_ip"
fi

done
