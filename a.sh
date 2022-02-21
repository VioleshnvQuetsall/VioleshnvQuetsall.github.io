#!/bin/bash

cd $(dirname $0)
git add -A && git commit -m 'regular update' && git push
