#!/usr/bin/env bash

envsubst < /config-template.php > /monast-php/lib/config.php
rm -f /usr/local/apache2/logs/httpd.pid
exec /usr/sbin/apache2ctl "$@"
