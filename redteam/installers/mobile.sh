#!/bin/bash

WORKDIR="/root/RedTeamToolkit/mobile"
GITHUB="https://github.com"

mkdir $WORKDIR

echo "Installing mobile tools"
pip3 install colorama prompt-toolkit pygments frida frida-tools
apt update && apt install -y gradlew
cd $WORKDIR
git clone $GITHUB/MobSF/Mobile-Security-Framework-MobSF.git
cd $WORKDIR
git clone https://github.com/optiv/mobile-nuclei-templates
cd $WORKDIR
git clone https://github.com/nettitude/scrounger.git && cd scrounger && pip install -r requirements.txt && python setup.py install
cd $WORKDIR
git clone git@github.com:dstotijn/hetty.git && cd hetty && make build
cd $WORKDIR
# git clone https://github.com/frida/frida.git && cd frida && make
git clone https://github.com/Nightbringer21/fridump.git
cd $WORKDIR
git clone https://github.com/0xdea/frida-scripts.git
git clone https://github.com/AloneMonkey/frida-ios-dump.git
cd $WORKDIR
git clone https://github.com/dwisiswant0/apkleaks && cd apkleaks && pip3 install -r requirements.txt
cd $WORKDIR
git clone https://github.com/FSecureLABS/drozer.git && cd drozer && make deb
cd $WORKDIR
git clone https://github.com/iBotPeaches/Apktool.git && cd Apktool && ./gradlew build shadowJar
cd $WORKDIR
git clone https://github.com/b-mueller/apkx && cd apkx && ./install.shadowJar
cd $WORKDIR
git clone https://github.com/pxb1988/dex2jar.github
git clone https://github.com/Storyyeller/enjarify.git
git clone https://github.com/skylot/jadx.git && cd jadx && ./gradlew dist
cd $WORKDIR
git clone https://github.com/java-decompiler/jd-gui.git && cd jd-gui && ./gradlew build
cd $WORKDIR
git clone https://github.com/linkedin/qark && cd qark && pip install -r requirements.txt && pip install . --user
cd $WORKDIR
git clone $GITHUB/MobSF/Mobile-Security-Framework-MobSF.git
git clone $GITHUB/dwisiswant0/apkleaks.git
cd $WORKDIR
echo "Done"
