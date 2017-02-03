FROM armhf/alpine

LABEL maintainer "rlogiacco@gmail.com"

ENV INLINECMS_VERSION 1.0.1
ENV HTDOCS /var/www/localhost/htdocs

RUN apk add --no-cache apache2 php5-apache2 php5-json php5-gd

RUN wget http://inlinecms.com/files/inlinecms-${INLINECMS_VERSION}.zip -P /tmp \
 && unzip -d ${HTDOCS} /tmp/inlinecms-${INLINECMS_VERSION}.zip \
 && rm -f /tmp/inlinecms-${INLINECMS_VERSION}.zip \
 && wget http://inlinecms.com/files/inlinecms.template.zip -P /tmp \
 && unzip -d ${HTDOCS}/theme /tmp/inlinecms.template.zip \
 && rm -f /tmp/inlinecms.template.zip

RUN touch /var/log/apache2/access.log \
 && touch /var/log/apache2/error.log \
 && ln -sf /dev/stdout /var/log/apache2/access.log \
 && ln -sf /dev/stderr /var/log/apache2/error.log \
 && mkdir -p /run/apache2 \
 && rm -f ${HTDOCS}/index.html

COPY httpd.conf /etc/apache2/

EXPOSE 80 443

VOLUME /var/www/localhost/htdocs/data
VOLUME /var/www/localhost/htdocs/theme

CMD httpd -D FOREGROUND