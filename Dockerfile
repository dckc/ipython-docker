FROM ubuntu
MAINTAINER Dan Connolly <dckc@madmode.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" \
    > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y python-pip libzmq-dev python-dev libc-dev

RUN pip install pyzmq ipython jinja2 tornado

EXPOSE 8888

CMD ipython notebook --no-browser --port 8888