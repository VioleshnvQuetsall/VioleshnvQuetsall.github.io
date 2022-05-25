#!/bin/bash

find ./_posts | while read f; do
	sed -i '/^layout:/d' "$f"
done
