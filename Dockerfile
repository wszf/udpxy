FROM debian:buster
MAINTAINER xxxxxx

# Set ENV
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /tmp
ENV IP 0.0.0.0

# Set Workdir
WORKDIR /tmp

# Install requirements
RUN apt-get update && apt-get install -y wget make gcc

# Install udpxy
RUN wget http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz
RUN tar -xzvf udpxy-src.tar.gz
RUN cd udpxy* && make && make install

# Cleanup
RUN apt-get -qqy remove make gcc > /dev/null \
    && apt-get -qqy autoremove --purge > /dev/null \
    && apt-get -qqy clean autoclean > /dev/null \
    && rm -rf /var/cache/apt/* /var/cache/debconf/* /var/lib/apt/* /var/lib/dpkg/* /tmp/* /var/tmp/* /var/log/*

# Set start command
#CMD ["/usr/local/bin/udpxy", "-T", "-p", "9983", "-c", "10"]
#ENTRYPOINT ["/usr/local/bin/udpxy","-v","-T","-a","0.0.0.0","-p","4022","-m",${IP},"-c","10","-B","1Mb","-M","60"]
CMD /usr/local/bin/udpxy -v -T -a 0.0.0.0 -p 4022 -m ${IP} -c 10 -B 1Mb -M 60
#CMD ["/usr/local/bin/udpxy", "-T", "-p", "9983", "-c", "10", "-v"]
#CMD ["/usr/local/bin/udpxy", ${UDPXY_OPTS}]
