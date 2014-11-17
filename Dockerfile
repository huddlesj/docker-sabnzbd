#
# build a docker container to run sabnzbd
#

FROM rednut/ubuntu:latest
MAINTAINER dotcomstu <dotcomstu@gmail.com>

# make apt non-interactive
ENV DEBIAN_FRONTEND noninteractive

# add ubuntu repos
ADD ./apt/ubuntu-sources.list /etc/apt/sources.list

# use local apt cache
#RUN mkdir -p /etc/apt/apt.conf.d/ && echo 'Acquire::http { Proxy "http://apt-cacher-ng:3142"; };' >> /etc/apt/apt.conf.d/01proxy

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# set locale
RUN locale-gen en_GB en_GB.UTF-8

# set correct time zone
RUN	echo "Europe/London" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata

RUN	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 16126D3A3E5C1192
RUN 	apt-mark hold initscripts udev plymouth mountall
RUN 	apt-get update && \
	apt-get -qy --force-yes dist-upgrade
RUN 	apt-get install -q -y curl wget supervisor apt-utils lsb-release curl wget rsync zip unzip unrar par2 util-linux \
			python-yenc unrar unzip lsb-release sabnzbdplus  sabnzbdplus-theme-classic sabnzbdplus-theme-iphone \
			sabnzbdplus-theme-mobile sabnzbdplus-theme-plush sabnzbdplus-theme-smpl python-cheetah python-configobj \
			python-feedparser sabnzbdplus-theme-plush python-dbus python-notify sabnzbdplus-theme-mobile par2 python-yenc \
			 unrar rar unzip 


VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8080 9191

ENTRYPOINT ["/start.sh"]




###RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe multiverse" >> /etc/apt/sources.list
###RUN apt-get -q update
##RUN apt-mark hold initscripts udev plymouth mountall
##RUN apt-get -qy --force-yes dist-upgrade
#RUN apt-get -q update
#RUN apt-get install -qy --force-yes sabnzbdplus sabnzbdplus-theme-classic sabnzbdplus-theme-mobile sabnzbdplus-theme-plush par2 python-yenc unrar unzip lsb-release

