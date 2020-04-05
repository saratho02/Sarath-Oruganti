FROM ubuntu:latest
MAINTAINER nevin.cleetus nevin.cleetus@gmail.com
RUN apt-get update
RUN apt-get install apache2 -y
COPY hello.html /var/www/html/
RUN apt-get install apache2-utils -y
RUN apt-get clean
EXPOSE 80
ENTRYPOINT ["apache2ctl"]
CMD ["-DFOREGROUND"]
