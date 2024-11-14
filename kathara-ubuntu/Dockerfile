FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    iproute2 \
    iputils-ping \
    net-tools \
    curl \
    vim \
    nano

RUN apt-get clean

CMD ["/bin/bash"]
