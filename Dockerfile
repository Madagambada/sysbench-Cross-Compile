FROM debian:latest

COPY i686.sh /root/i686.sh
RUN ["chmod", "+x", "/root/i686.sh"]
RUN /root/i686.sh
