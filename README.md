# SneakyBeagle container

Simple docker compose file and Dockerfiles to build a kali container, a Nessus container, a container with a complete toolkit for Red Team operations, and a container with Infection Monkey for continuous pentesting, and attack simulations. Made to simplify deployments during pentests, vulnerability scans and Red Team Campaigns.

Exposes ports 2222,5000 and 8834 on the hosting machine. Port 2222 is used to SSH into the kali container and port 8834 is used to expose Nessus. Infection Monkey exposes port 5000. Settings can be changed in the environment file, see [Step 1](#step-1).
==================================================================================================================================================================================================================================================

![Kali Build](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/docker-kali-image.yml/badge.svg)
![Quantum Build](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/docker-quantum-image.yml/badge.svg)
![Nessus Build](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/docker-nessus-image.yml/badge.svg)
![Redteam Build](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/docker-redteam-image.yml/badge.svg)
![InfectionMonkey Build](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/docker-infectionmonkey-image.yml/badge.svg)
[![Update README with installed packages](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/update-readme.yml/badge.svg)](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/update-readme.yml)
![Published containers](https://github.com/SneakyBeagle/SneakyBeagle_container/actions/workflows/docker-publish.yml/badge.svg)

Simple docker compose file and Dockerfiles to build a Kali container, a Quantum Tunnel container, a Nessus container, a container with a complete toolkit for Red Team operations, and a container with Infection Monkey for continuous pentesting, and attack simulations. Made to simplify deployments during pentests, vulnerability scans and Red Team Campaigns.

Exposes ports 2222, 22222, 5000 and 8834 on the hosting machine. Port 2222 is used to SSH into the kali container, port 22222 is used to SSH into the redteam container and port 8834 is used to expose Nessus. Infection Monkey exposes port 5000. Settings can be changed in the environment file, see [Step 1](#step-1).

# Pull existing containers:

Instead of building them, you can also download prebuilt images with the following commands:

(The tag should be added based on the latest (or preferred) version found in the [packages](https://github.com/orgs/SneakyBeagle/packages?repo_name=SneakyBeagle_container).)

```
docker pull ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakykali:<tag>
```

```
docker pull ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakyredteam:<tag>
```

```
docker pull ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakynessus:<tag>
```

```
docker pull ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakyquantum:<tag>
```

and run them with

```
docker run ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakykali:<tag>
```

```
docker run ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakyredteam:<tag>
```

```
docker run ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakynessus:<tag>
```

```
docker run ghcr.io/sneakybeagle/sneakybeagle_container/sneakybeagle_container.sneakyquantum:<tag>
```

This will result in a setup that uses the credentials and settings that can be found in the example [env](env) file. This means that you should change the credentials as soon as possible and will use the free version of nessus, since no activation code is provided (obviously...).

# Create containers:

## Step 1:

Copy "env" to ".env".

```
cp env .env
```

Enter (in .env) the Nessus activation code, a username and a password, and a password to ssh into the kali machine.

You can also change the default port for Infection Monkey.
==========================================================

Enter (in .env) the server address and port that you opened externally (if you want to access these containers remotely), the Nessus activation code, a username and a password for nessus, and a password to ssh into the kali and redteam containers.

As in the following example:

```
Nessus
=======
# Quantum Tunnel
SERVER=example.com
SERVERPORT=22 # Server SSH port to connect to, probably good to do 443 to avoid firewall rules
SERVERUSER=root

# Nessus
ACTIVATION_CODE=AAAA-BBBB-CCCC-DDDD
USERNAME=admin
PASSWORD=awesomepassword
NESSUSHOSTPORT=8834

# SSH
SSHPASSWORD=anotherawesomepassword
SSHHOSTPORT=2222

# SSH port on host for Kali
SSHHOSTPORT=2222

# SSH port on host for redteam
RTSSHHOSTPORT=22222

# Storage/Volumes
BASEVOLUME=./docker_vols/
```

Optionally, you can also configure the ports that the hosting machine will expose for the services.

### [Optional] Step 1.2:

A number of optional tools can be installed in the Kali container. This is disabled by default to speed up the build, but can be enabled by uncommenting the following lines in the [Kali Dockerfile](kali/Dockerfile):

```
## UNCOMMENT TO INSTALL OPTIONAL
#COPY files/install_optional.sh /root/install_optional.sh
#RUN chmod +x /root/install_optional.sh && /root/install_optional.sh && rm /root/install_optional.sh
```

The default tools can be found [here](#kali) and the optional tools can be found [here](#optional)

## Step 2:

This script is copied into the container, so even if not used during build, it can be run later on the container directly.

The default tools can be found [here](#kali) and the optional tools can be found [here](#optional)

## [Optional] Step 1.3:

If you are using the quantum tunnel container, you need to setup a SSH key pair, copy it into the right directory for the container and copy the public key to your external servers 'authorized_keys' file. Here is how to do that:

On the host that will run the containers:

```
mkdir -p <location_of_repository>/quantum/files
```

Next, generate keys into this directory (without passphrase):

```
ssh-keygen -t rsa -q -N "" -f <location_of_repository>/quantum/files/id_rsa
```

Now copy ``<location_of_repository>/quantum/files/id_rsa.pub`` to ``$HOME/.ssh/authorized_keys`` on your external server (I would also suggest using this key to authenticate with your own machine to check if it works).

## Step 2:

```
docker-compose build [service]
```

This will parse the docker-compose.yml file and start building the images accordingly. You can either build all services by running:

```
docker-compose build
```

Or build a specific service, like for example only Nessus, by running

```
docker-compose build nessus
```

Instead of building them, you can also download prebuilt images for kali and redteam (step 3 can be ignored in this case):

```
docker pull dvd42/sneakykali

docker pull dvd42/sneakyredteam

```

and run them with

```
docker run -it dvd42/sneakykali

docker run -it dvd42/sneakyredteam
```

docker-compose build nessus # can also be redteam or kali or quantum

```

### Note:
The quantum service will either use a existing public/private keypair (located in ```quantum/files/```) to authenticate to your external server, or will generate the keys if they do not exists. In either case, during the build the public key will be printed. This should be copied to your servers ```$HOME/.ssh/authorized_keys```. For more info, go back to Optional Step 1.3.

## Step 3:

Depending on what service(s) you want to run, the following commands can be used:

```

```
docker-compose up -d
docker-compose up -d nessus
```

`docker-compose up -d kali`

```

```

docker-compose up -d redteam
============================

and running a single container:

docker-compose up -d [service] # nessus, kali or redteam or quantum

The Infection Monkey container is executed by an independent script, located under infectionmonkey/ directory, that downloads required files and executes them.

```
sudo infection_docker.sh
```

# Stop containers

To stop the containers, run:

```
docker-compose stop
```

# Remove containers

To remove the containers, once stopped, run:

```
docker-compose rm
```

# Installed tools

## Kali

Container information

## Kali

A Kali container that opens a SSH port on the host and has a number of tools already installed.

* **Installed tools:**
* ssh

- apt-utils
- wget
- curl
- netcat-traditional
- nmap
- gobuster
- python3
- python3-pip
- iproute2
- dnsutils
- iputils-ping
- emacs-nox
- sqlmap
- whois
- nikto
- wget
- ssh
- net-tools
- git
- nfs-common
- tcpdump
- seclists
- kali intel suite

## Optional

- inetutils-traceroute
- vim
- golang-go
- python3.9-venv
- man-db
- w3m
- exploitdb
- smbclient
- dsniff
- testssl.sh
- commix
- hydra
- vim
- golang-go
- mydumper
- PayloadsAllTheThings
- kali-whoami

# Red Team

Split into categories, each script installs a defined toolkit for all red team phases and attack vectors.
With sometools.sh script you can add some more tools or keep the installed ones updated.

* Active Directory

  * ADEnum
  * Bloodhound
  * ADalanche
  * LDAPdomaindump
  * Icebreaker
  * Kerbearoast
* Anon

  * TOR
  * TORsocks
    ========

- mydumper
- python2
- tar
- tor
- python3-scapy
- sqsh
- metasploit-framework
- netdiscover
- iptraf-ng
- kali-archive-keyring
- terminator
- httpie
- python3-poetry
- bash-completion

<!---END-MARK-KALI-OPTIONAL--->

## Quantum Tunnel

The Quantum Tunnel host uses [Quantum Tunnel](https://github.com/SneakyBeagle/quantum_tunnel), a reverse forward ssh tunneler written in Go. This creates a tunnel from the server you specify in the .env file and the kali host, meaning you can access the kali host from within the external server, even with restrictive firewall/NAT rules in place.

## Red Team

Split into categories, each script installs a defined toolkit for all red team phases and attack vectors.
With sometools.sh script you can add some more tools or keep the installed ones updated.

* General tools

<!---START-MARK-RT--->

- openssh-server
- zsh
- net-tools
- apt-utils
- python3
- python3-dev
- build-essential
- python3-pip
- redis-server
- terminatorwget
- vim
- gnupg2
- postgresql
- python3-venv
- apt-transport-https
- lsb-release
- libreadline-dev
- libpq5
- libpq-dev
- readline-common
- libsqlite3-dev
- libpcap-devsubversion
- git-core
- autoconf
- zlib1g-dev
- libxml2-dev
- libxslt1-dev
- libyaml-dev
- ruby1.9.1
- nmap
- iputils-ping
- netdiscover
- hping3netcat-traditional
- gobuster
- iproute2
- iputils-arping
- dnsutils
- tcpdump
- powershell
- curl

Anon

* TOR
* TORsocks
* I2P
* ProxyChains
* OpenVPN
* Wireguard
* TorGhost

Evasion

* UACME
* mortar
* DKMC

Exfiltration

* Mistica
* DNSExfiltration
* Egress-assess
* Data Exfiltration Toolkit
* Powershell-RAT
* PyExfil

Exploitation

* impacket
* BEEF
* bettercap
* Metasploit Framework
* CVE-2021-44228 PoC log4j bypass words
* Log4Shell RCE Exploit
* GimmeSH

Mobile

* Mobile Security Framework
* Nuclei Mobile templates
* Frida
* Frida scripts
* Fida iOS dump
* Fridump
* Scrounger
* APKleaks
* Drozer
* APKtool
* APKX
* dex2jar
* enjarify
* jadx
* jd-gui
* qark
* Exploitation
* jok3r Framework
* CVE-2021-44228 PoC log4j bypass words
* Log4Shell RCE Exploit
* AD Enum

Phishing

* Social Engineer Toolkit
* Phishing Pretexts
* Phishery
* ZPhisher
* King Phiser
* Evilginx2
* evil-ssdp
* FiercePhish
* GoPhish
* ReelPhish
* CredSniper



PostExploitation

* Empire Framework 4
* Starkiller
* StarFighters
* Pupy
* gcat
* Merlin
* weevely
* Powersploit


Privilege Escalation

* BeRoot
* LinEnum
* Linux Exploit Suggester
* linuxprivchecker
* Linux Smart Enumeration
* JAWS
* Windows Exploit Suggester NG
* WindowsEnum
* Log4j CVE-2021-45046
* Responder
* Windows Kernel Exploits
* CVE-2021-4034


Vulnerability Scan

* CVE-2021-44228 Scanner
* Log4J CVE Detect
* espoofer
* Domain Security Scanner
* dkimsc4n
* testssl.sh
* Nuclei
* CVE-2018-20250
* CVE-2017-8759
* CVE-2017-0199
* CVE-2017-8570
* demiguise
* Malicious Macro Generator
* DKMC
* Office DDE Payloads
* DZGEN
* EmbedinHTML
* Macro Pack
* DInjector
* Unicorn
* The Backdoor Factory
* Generate Macro
* MaliciousMacroMSBuild
* wePWNise
* trojanizer
* Macro Shop
* EvilClippy
* donut
* Evilgrade

## Infection Monkey

There is a script included in this repository that allows you to easily setup a Monkey Island container. This script can be found [here](infectionmonkey/infection_docker.sh). Running this script will attempt to stop and remove existing Monkey Island and mongo-db (named "monkey-mongo") containers, and create and run new ones.

Refer to [documentation](https://www.guardicore.com/infectionmonkey/docs/) for further information.
