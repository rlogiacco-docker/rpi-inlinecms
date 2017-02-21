FROM multiarch/alpine:armhf-v3.5

LABEL maintainer "Roberto Lo Giacco <rlogiacco@gmail.com>"
LABEL org.label-schema.vcs-url "https://github.com/rlogiacco-docker/rpi-inlinecms"

ARG INLINECMS_VERSION=1.0.1

RUN apk add --no-cache apache2 php5-apache2 php5-json php5-gd

ENV INLINECMS_VERSION=$INLINECMS_VERSION \
    INLINECMS_STORE=/var/inlinecms \
    HTDOCS=/var/www/localhost/htdocs
    
RUN mkdir -p ${INLINECMS_STORE} \
 && wget http://inlinecms.com/files/inlinecms-${INLINECMS_VERSION}.zip -P /tmp \
 && unzip -d ${HTDOCS} /tmp/inlinecms-${INLINECMS_VERSION}.zip \
 && mv ${HTDOCS}/data ${INLINECMS_STORE} \
 && mv ${HTDOCS}/theme ${INLINECMS_STORE} \
 && mv ${HTDOCS}/upload ${INLINECMS_STORE} \
 && ln -s ${INLINECMS_STORE}/data ${HTDOCS}/data \
 && ln -s ${INLINECMS_STORE}/theme ${HTDOCS}/theme \
 && ln -s ${INLINECMS_STORE}/upload ${HTDOCS}/upload \
 && wget http://inlinecms.com/files/inlinecms.template.zip -P /tmp \
 && unzip -d ${INLINECMS_STORE}/theme /tmp/inlinecms.template.zip \
 && rm -f /tmp/*

RUN touch /var/log/apache2/access.log \
 && touch /var/log/apache2/error.log \
 && ln -sf /dev/stdout /var/log/apache2/access.log \
 && ln -sf /dev/stderr /var/log/apache2/error.log \
 && mkdir -p /run/apache2 \
 && rm -f ${HTDOCS}/index.html

COPY httpd.conf /etc/apache2/

EXPOSE 80

VOLUME /var/inlinecms

CMD httpd -D FOREGROUND