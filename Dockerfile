FROM ubuntu
MAINTAINER Dan Connolly <dckc@madmode.com>

# Usage:
# sudo docker build -t ipython-notebook .
# sudo docker run -p 8123:8888 -v `/bin/pwd`:/notebooks  -t ipython-notebook
#
# Tested with Docker version 0.7.2, build 28b162e
# Ref: http://www.docker.io/ , http://docs.docker.io/en/latest/use/builder/

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" \
    > /etc/apt/sources.list
RUN apt-get update

# Runtime depedencies
RUN apt-get install -y python
RUN apt-get install -y libzmq1

# Dev tools.
# Install,  use them, and then clean up in one RUN transaction
# to minimize image size.
RUN (apt-get install -y python-pip libzmq-dev python-dev libc-dev; \
     pip install pyzmq ipython jinja2 tornado; \
     apt-get remove python-pip libzmq-dev python-dev libc-dev; \
     apt-get autoremove)

VOLUME /notebooks
WORKDIR /notebooks

EXPOSE 8888

CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888
