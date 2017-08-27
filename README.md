# Docker image for TURN server
A Docker container with the [Coturn TURN server](https://github.com/coturn/coturn)

Build with:
docker build -t turnserver:0.1.0 .

docker run -d -p 3478:3478 -e "TURN_USER=foo" -e "TURN_PASS=bar" -e "TURN_REALM=mydomain" mrballcb/turnserver

It is not really intended to be used standalone.  It is intended to be used in
AWS, fronted by an ELB that is doing TLS with simple http on the backend into
this container running in Kubernetes.

The local cli interface is active.  To disable it, you need to add *-e TURN_ARGS="--no-cli"*
to the commandline.

Adapted from original work done by: Anastasia Zolochevska <anastasiia.zolochevska@gmail.com>

sudo docker run -d -p 3478:3478 -p 3478:3478/udp --restart=always zolochevska/turn-server username password realm
