FROM node:4.2.1
MAINTAINER Yago Silvela 

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
RUN echo "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen" | tee -a /etc/apt/sources.list.d/10gen.list
RUN apt-get -y update
RUN apt-get -y install mongodb-10gen

RUN easy_install supervisor
RUN echo_supervisord_conf > /etc/supervisord.conf
RUN printf "[include]\nfiles = /var/www/Supervisorfile\n" >> /etc/supervisord.conf

ADD . /var/www

RUN cd /var/www ; npm install 

CMD ["/usr/local/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"] 
