FROM ubuntu:12.04
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
RUN apt-get install -y python python-pip
RUN apt-get install -y libzmq1

# Dev tools.
# Install,  use them, and then clean up in one RUN transaction
# to minimize image size.
RUN (apt-get install -y libzmq-dev python-dev libc-dev; \
     pip install pyzmq ipython jinja2 tornado; \
     apt-get remove -y --purge libzmq-dev python-dev libc-dev; \
     apt-get remove -y --purge gcc cpp binutils; \
     apt-get autoremove -y; \
     apt-get clean -y)

VOLUME /notebooks
WORKDIR /notebooks

# Formal Logic in Python (FLiP)
RUN pip install flip

# for converting notebooks...
RUN pip install pygments
RUN apt-get install -y pandoc

EXPOSE 8888

CMD ipython notebook --no-browser --ip=0.0.0.0 --port 8888
