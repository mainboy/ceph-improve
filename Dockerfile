
FROM ubuntu:14.04
MAINTAINER Kang Yan "wowyk@qq.com"

# install deps
RUN apt-get update
RUN apt-get -y install automake
RUN apt-get -y install autotools-dev autoconf automake cdbs gcc g++
RUN apt-get -y install git libboost-dev libedit-dev libssl-dev libtool libfcgi libfcgi-dev libfuse-dev linux-kernel-headers
RUN apt-get -y install pkg-config uuid-dev libkeyutils-dev libgoogle-perftools-dev libatomic-ops-dev libaio-dev libgdata-common libsnappy-dev libleveldb-dev libblkid-dev xfslibs-dev libboost-thread-dev libboost-program-options-dev librados2 librbd1
RUN apt-get -y install libudev-dev
RUN apt-get -y install libcrypto++-dev libcrypto++ libexpat1-dev
RUN apt-get -y install libboost-random-dev
RUN apt-get -y install python-setuptools

# copy ceph source code
COPY ceph-0.87.opt/ /ceph

# install
RUN cd /ceph && ./autogen.sh
RUN cd /ceph && ./configure
RUN cd /ceph && make -j16
RUN cd /ceph && make install
RUN cp /ceph/src/init-ceph /etc/init.d/ceph

RUN rm -rf /ceph 

# entrypoint
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
