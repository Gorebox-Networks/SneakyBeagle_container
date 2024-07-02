FROM kalilinux/kali-bleeding-edge:latest
LABEL author="cbk914"
LABEL description="Container for Red Team Campaign"
ARG SSHPASSWORD
ARG DEBIAN_FRONTEND=noninteractive

# PACKAGES #
ARG packages="openssh-server zsh net-tools apt-utils python3 python3-dev build-essential python3-pip redis-server terminator \
    wget vim gnupg2 postgresql python3-venv apt-transport-https lsb-release libreadline-dev libpq5 libpq-dev readline-common libsqlite3-dev libpcap-dev \
    subversion git-core autoconf zlib1g-dev libxml2-dev libxslt1-dev libyaml-dev ruby1.9.1 nmap iputils-ping netdiscover hping3 \
    netcat-traditional gobuster iproute2 iputils-arping dnsutils tcpdump powershell curl"
# END PACKAGES #

# Configuration files
COPY conf/.vimrc /root/.vimrc
COPY conf/.zshrc /root/.zshrc
COPY conf/.bashrc /root/.bashrc
COPY conf/sshd_config /etc/ssh/sshd_config

# Commands
COPY commands/whichsystem.py /usr/local/bin/whichsystem

RUN apt-get update && apt-get install -y apt-utils curl netcat-traditional gnupg2 postgresql python3-venv apt-transport-https lsb-release libpcap-dev \
    nmap gobuster python3 python3-dev build-essential python3-pip iproute2 dnsutils iputils-ping redis-server sqlmap terminator whois powershell libpcap-dev \
    nikto wget ssh net-tools git nfs-common tcpdump seclists inetutils-traceroute vim golang-go libreadline-dev libpq5 libpq-dev readline-common \
    subversion git-core autoconf zlib1g-dev libxml2-dev libxslt1-dev libyaml-dev ruby1.9.1 nmap openssh-server zsh iputils-ping netdiscover hping3 libsqlite3-dev

# Ensure the system is up to date
RUN apt-get upgrade -y    

# RedTeamToolkit

# Python env
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN mkdir /root/RedTeamToolkit
COPY installers/*.sh /root/RedTeamToolkit/
RUN chmod +x /root/RedTeamToolkit/*.sh && cd /root/RedTeamToolkit/ && git clone https://github.com/som3canadian/Some-Tools.git && cd Some-Tools && chmod +x sometools.sh && \
    ./sometools.sh setup

# setup for ssh (change password ASAP)
RUN echo "root:$RTSSHPASSWORD" | chpasswd && service ssh start
EXPOSE 22

# Python env
RUN ln -s /usr/bin/python3 /usr/bin/python

# setup for ssh (change password ASAP)
RUN echo "root:$SSHPASSWORD" | chpasswd && service ssh start

# Cleanup
RUN touch /root/.hushlogin && apt-get autoremove -y && apt-get autoclean -y

WORKDIR /root/RedTeamToolkit
