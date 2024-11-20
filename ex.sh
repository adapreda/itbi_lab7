#!/bin/bash

cat /etc/hosts | while read -r line; do
	if [[ "$line" == "" || "$line" == \#* ]]; then
		continue
	fi

ip=$(echo "$line" | cut -d ' ' -f 1)
name=$(echo "$line" | cut -d ' ' -f 2)

resolved_ip=$(nslookup "$name" 2>/dev/null | grep 'Address:' | cut -d ':' -f 2 | grep $ip | cut -b 2-)

if [[ "$resolved_ip" != "$ip" &&  "$resolved_ip" != "" ]]; then
	echo "Bogus IP for $name in /etc/hosts! Expected: $ip, Got: $resolved_ip"
elif [[ "$resolved_ip" == "$ip" && "$resolved_ip" != "" ]]; then
	echo "Adresa $resolved_ip este corecta!"
fi

done
