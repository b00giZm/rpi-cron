FROM hypriot/rpi-alpine-scratch
MAINTAINER Pascal Cremer "b00gizm@gmail.com"

RUN apk update \
    && apk upgrade \
    && apk add \
        bash \
    && rm -rf /var/cache/apk/*

COPY start-cron.sh /usr/bin/start-cron
COPY docker-entrypoint.sh /

RUN chmod -R +x /etc/periodic/ \
    && chmod +x /usr/bin/start-cron \
    && chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/bin/start-cron"]
