FROM resin/rpi-raspbian
MAINTAINER Pascal Cremer "b00gizm@gmail.com"

RUN apt-get update \
    && apt-get upgrade \
    && apt-get install \
        cron \
        rsyslog \
    && apt-get autoremove \
    && apt-get clean

COPY start-cron.sh /usr/bin/start-cron
COPY docker-entrypoint.sh /

RUN chmod +x /usr/bin/start-cron \
    && chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/bin/start-cron"]
