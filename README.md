# Monast-PHP Asterisk Monitor Docker Image

This is a dockerized version of the PHP-based UI of the [Monast Asterisk Monitor Project](https://dagmoller.github.io/monast/).
Will need to be run in conjunction with [rgielen/monast-pymon-docker](https://hub.docker.com/r/rgielen/monast-pymon-docker/), e.g. in docker-compose.

When run, the following environment variables can be adjusted:
  * `PYMON_HOST=localhost` Host where Monast pymon runs
  * `PYMON_PORT=5039` Pymon Port to use
  * `MONAST_LANGUAGE=en` Monast PHP language setting
  
Port 80 is exposed.
See [Dockerfile](Dockerfile) and [config-template.php](config-template.php) for more details.

Here is an example docker-compose.yml that combines Monast pymon and Monast PHP image:

```
version: '2'

networks:
  monast-backend:
    driver: bridge

services:

 monast-pymon:
  image: rgielen/monast-pymon-docker
  environment:
    - ASTERISK_HOST=192.168.1.11
    - AMI_USERNAME=monast
    - AMI_PASSWORD=secret
    - USER_ADMIN_SECRET=monast_php_admin_secret
    - USER_AGENT_SECRET=monast_php_agent_secret
  networks:
    - monast-backend

 monast-php:
  image: rgielen/monast-php-docker
  depends_on:
    - monast-pymon
  ports:
    - "8080:80"
  environment:
    - PYMON_HOST=monast-pymon
    - 
  networks:
    - monast-backend
```

So given you have
 * Asterisk running on 192.168.1.11
 * configured an Asterisk AMI user `monast` with password `secret` in `manager.conf`

this would expose Monast PHP service
 * on Port 8080 of your Docker host
 * with login admin / monast_php_admin_secret
 * or with login agent / monast_php_agent_secret 
