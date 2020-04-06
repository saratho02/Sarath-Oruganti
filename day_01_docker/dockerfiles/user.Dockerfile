FROM ubuntu:latest

RUN apt-get update
RUN apt-get install sudo

RUN adduser --disabled-password --gecos '' nevin
RUN adduser nevin sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER nevin

CMD ping localhost
