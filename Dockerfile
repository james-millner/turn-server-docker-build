FROM ubuntu:16.04
MAINTAINER Todd Lyons <todd.lyons@pgi.com>

ENV COTURN_VER 4.5.0.3-1build1

EXPOSE 3478

RUN apt-get update && \
    apt-get install -y dnsutils coturn=${COTURN_VER} && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY deploy-turnserver.sh /root/deploy-turnserver.sh
COPY turnserver.conf /etc/turnserver/

CMD ["bash", "/root/deploy-turnserver.sh"]
