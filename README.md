rpi-inlinecms
==============

[![](https://images.microbadger.com/badges/image/rlogiacco/rpi-inlinecms.svg)](https://microbadger.com/images/rlogiacco/rpi-inlinecms) [![](https://images.microbadger.com/badges/version/rlogiacco/rpi-inlinecms.svg)](https://microbadger.com/images/rlogiacco/rpi-inlinecms)

Based on Alpine for ARM this image delivers a fully configured and ready to run instance of [InlineCMS](http://inlinecms.com/) based on Apache HTTP Server and PHP5.


# Description
You should run this container on the background and mount a volume to make the CMS content persistent.

Includes:

 - Apache HTTP Server
 - PHP5
 - InlineCMS
 
## Volumes
Exports a volume on `/var/www/localhost/htdocs/data`, where your CMS content is stored, and on `/var/www/localhost/htdocs/theme`, where your HTML template content is stored.
You should mount the volume `/var/www/localhost/htdocs/data` to make it permanent. Optionally, if you wish to customize the templates used as theme, you can also mount `/var/www/localhost/htdocs/theme`.

If you wish to customize the Apache HTTP Server configuration you can do so by providing a replacement mount for `/etc/apache2/httpd.conf` (global configuration) or adding files under `/etc/apache2/conf.d/` (all included by default).
 
## Ports
Two ports are exposed:

 - 80: default HTTP port
 - 443: default HTTPS port (disabled)

Remember to map the ports to the docker host on run.


# How to run the container
## Using docker
To get the container up and running, run:
 
```
sudo docker run -d -p 8080:80 sudo docker run --name inlinecms -v inlinecms:/var/www/localhost/htdocs/data -d rlogiacco/rpi-inlinecms
```


# Links

 - [Source Repository](https://github.com/rlogiacco-docker/rpi-inlinecms)
 - [Dockerfile](https://github.com/rlogiacco-docker/rpi-inlinecms/blob/master/Dockerfile)
 - [DockerHub](https://registry.hub.docker.com/u/rlogiacco/rpi-inlinecms/)