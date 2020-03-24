FROM ubuntu:bionic

MAINTAINER people

# update the base image
RUN apt-get update && \
    apt-get install --no-install-recommends apt-utils -yqq && \
    apt-get upgrade -yqq

# install Apache HTTPD
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid 
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get -y install curl apache2=2.4.29-* apache2-utils=2.4.29-* && \
    a2dismod mpm_prefork && \
    a2dismod mpm_event && \
    a2dismod ssl && \
    a2enmod mpm_worker && \
    mkdir /var/www/infobase

VOLUME /var/www/infobase

RUN curl -SL https://filesvy38.s3.eu-central-1.amazonaws.com/deb/deb64_8_3_16_1148.tar.gz | tar zxf - -C /tmp && \
    dpkg --install /tmp/1c-enterprise83-ws_* /tmp/1c-enterprise83-common_* /tmp/1c-enterprise83-server_*

EXPOSE 80/tcp
WORKDIR $APACHE_RUN_DIR

RUN apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

CMD ["apache2", "-X"]

