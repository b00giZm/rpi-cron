#!/bin/bash

env | sed 's/\(=[[:blank:]]*\)\(.*\)/\1"\2"/' | awk '{print "export " $0}' > /env.sh

/usr/sbin/crond -f -d 8
