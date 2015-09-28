FROM ubuntu:trusty
MAINTAINER Nick Andrew <nick@nick-andrew.net>
EXPOSE 5901

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y upgrade

RUN adduser --gecos 'User Name,,,' --disabled-password user
RUN usermod -a --groups dialout user

RUN apt-get -y install firefox
RUN apt-get -y install vnc4server blackbox xterm libpulse0 command-not-found
ADD bin /root/bin

RUN apt-get -y install wget unzip default-jre
RUN wget -O /tmp/ESPlorer.zip 'http://esp8266.ru/esplorer-latest/?f=ESPlorer.zip'

WORKDIR /opt
RUN unzip /tmp/ESPlorer.zip

WORKDIR /root
