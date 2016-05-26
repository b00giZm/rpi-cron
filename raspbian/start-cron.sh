#!/bin/bash

touch /etc/crontab
touch /var/log/cron.log

env | sed 's/\(=[[:blank:]]*\)\(.*\)/\1"\2"/' | awk '{print "export " $0}' > /env.sh

for cron in /crons/*; do
	if [ -f "$cron" ]; then
		cp $cron /etc/cron.d/${cron##*/}
	fi
done

rsyslogd && cron && tail -f /var/log/cron.log /var/log/syslog
