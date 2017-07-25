# Monast-PHP Asterisk Monitor Docker Image

This is a dockerized version of the PHP-based UI of the [Monast Asterisk Monitor Project](https://dagmoller.github.io/monast/).
Will need to be run in conjunction with [rgielen/monast-pymon-docker](https://hub.docker.com/r/rgielen/monast-pymon-docker/), e.g. in docker-compose.

When run, the following environment variables can be adjusted:
  * `PYMON_HOST=localhost` Host where Monast pymon runs
  * `PYMON_PORT=5039` Pymon Port to use
  * `MONAST_LANGUAGE=en` Monast PHP language setting
  
Port 80 is exposed.
See [Dockerfile](Dockerfile) and [config-template.php](config-template.php) for more details.
