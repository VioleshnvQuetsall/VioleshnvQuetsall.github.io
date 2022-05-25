#!/bin/bash

for f in $(find ./_posts); do
	if [ -f "$f" ]; then
		sed -i '/^post:/d' "$f"
	fi
	echo $f
done	
