docker sabnzbd
==============

This is a Dockerfile to set up "SABnzbd" - (http://sabnzbd.org/)

Build from docker file

```
git clone git@github.com:timhaak/docker-sabnzbd.git
cd docker-sabnzbd
docker build -t sabnzbd . 
```

Start:
docker run -d -h sabnzbd --name="sabnzbd" -v /srv/data/apps/docker/sabnzbd/config:/config -v /srv/data/apps/docker/sabnzbd/data:/data -p 8085:8080 -p 9090:9090 rednut/sabnzbd

docker run -d -h *your_host_name* -v /*your_config_location*:/config -v /*your_videos_location*:/data -p 8080:8080 -p 9090:9090 sabnzbd

