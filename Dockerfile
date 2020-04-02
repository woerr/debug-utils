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

RUN useradd -m weldbook

RUN mkdir /var/run/sshd
RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
