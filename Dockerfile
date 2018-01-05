FROM debian:jessie-slim
MAINTAINER vistalba

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /tmp

WORKDIR /tmp

RUN apt-get update && apt-get install -y wget make gcc
RUN wget http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz
RUN tar -xzvf udpxy-src.tar.gz
RUN cd udpxy* && make && make install

CMD ["/usr/local/bin/udpxy", "-T", "-p", "9983"]
