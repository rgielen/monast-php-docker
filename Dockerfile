FROM ubuntu:trusty
MAINTAINER "Rene Gielen" <rgielen@apache.org>

RUN apt-get update && apt-get upgrade -y \
      && apt-get install -y --no-install-recommends \
           apache2 \
           php7.0 \
           php-pear \
           libapache2-mod-php7.0 \
           wget \
           unzip \
           gettext-base \
           ca-certificates \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/* \
      && rm -rf /tmp/*

# RUN pear install HTTP_Request2
RUN pear install HTTP_Client
RUN cat /usr/share/php/HTTP/Client.php | sed -e "s/=&/=/g" > /usr/share/php/HTTP/Client.php

RUN wget https://github.com/dagmoller/monast/archive/master.zip \
        && unzip master.zip \
        && rm -rf monast-master/pymon \
        && mv monast-master /monast-php \
        && chgrp -R www-data /monast-php \
        && rm master.zip

ADD 000-default.conf /etc/apache2/sites-available/
ADD config-template.php /
ADD configure-and-start.sh /

ENV PYMON_HOST=localhost
ENV PYMON_PORT=5039
ENV MONAST_LANGUAGE=en

EXPOSE 80
ENTRYPOINT ["/configure-and-start.sh", "-D", "FOREGROUND"]
