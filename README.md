Usage:
sudo docker build -t ipython-notebook .
sudo docker run -p 8123:8888 -v `/bin/pwd`:/notebooks  -t ipython-notebook

MAINTAINER Dan Connolly <dckc@madmode.com>

Tested with Docker version 0.7.2, build 28b162e

Refs:
 - [docker](http://www.docker.io/)
 - [Dockerfile reference](http://docs.docker.io/en/latest/use/builder/)

License: MIT
