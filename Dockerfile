FROM debian:latest

COPY i686.sh /root/i686.sh
COPY armhf.sh /root/armhf.sh
RUN ["chmod", "+x", "/root/i686.sh"]
RUN ["chmod", "+x", "/root/armhf.sh"]
RUN /root/i686.sh
RUN /root/armhf.sh
