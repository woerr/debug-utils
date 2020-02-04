FROM ubuntu:19.10

ENV TZ=Europe/Moscow
ENV LANGUAGE ru_RU.UTF-8
ENV LANG ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y tzdata && \
echo "$TZ" > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y language-pack-ru && \
update-locale LANG=ru_RU.UTF-8 && \
locale-gen ru_RU.UTF-8 && \
dpkg-reconfigure locales

RUN apt-get install -y \
    dnsutils \
    net-tools \
    nmap \
    tcpdump \
    iproute2 \
    python3 \
    git \
    curl \
    wget \
    vim \
    neovim \
    nano \
    htop \
    iftop \
    iptraf iptraf-ng \
    nethogs \
    screenfetch \
    speedometer \
    mc \
    sshpass \
    ssh

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
apt-get install -y nodejs && \
npm install -g yarn@berry

EXPOSE 22

CMD /bin/bash