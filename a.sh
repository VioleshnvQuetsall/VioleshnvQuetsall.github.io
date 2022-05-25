#!/bin/bash

for f in $(find ./_posts); do
	if [ -f "$f" ]; then
		sed -i '/^layout:/d' "$f"
	fi
	echo $f
done	
