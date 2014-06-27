FROM ubuntu:precise
MAINTAINER dotcomstu <dotcomstu@gmail.com>

RUN mkdir -p /etc/apt/apt.conf.d/ && echo 'Acquire::http { Proxy "http://10.9.1.9:3142"; };' >> /etc/apt/apt.conf.d/01proxy
RUN locale-gen en_GB en_GB.UTF-8


RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe multiverse" >> /etc/apt/sources.list

RUN apt-get -q update
RUN apt-mark hold initscripts udev plymouth mountall
RUN apt-get -qy --force-yes dist-upgrade

#RUN apt-get -q update

RUN apt-get install -qy --force-yes sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush par2 python-yenc unrar unzip 

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8080 9090

ENTRYPOINT ["/start.sh"]
