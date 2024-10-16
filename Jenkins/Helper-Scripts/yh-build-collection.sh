#!/bin/bash
# set -x
year=$(date +'%Y') 
month=$(date +'%m')
dat=$(date +'%d')
currtime=$(date +%H:%M)
WORKSPACE=/home/jenkins/workspace/YellowHammer-Pipeline
Release=RC$(grep 'version' $WORKSPACE/yellowhammer/pom.xml | head -1| tr -d '\t</version>'| tr -d '\r')
# Release=RC2.0.9
CLI_Release=Release2.0.0

#GETTING REV NUMBER
cd ${WORKSPACE} || exit 3
hg tip | head -2 | sed 1d | awk '{print $2}' > revision.txt
# rev=`hg tip | awk '{print $2}' | head -n 1 | cut -d ':' -f 1`
branch=$(hg id | awk '{print $2}' | sed 's/(//' | sed 's/)//')
rev=$(hg id -n | tr -d '+')
cd - > /dev/null 2>&1 || exit 3 

DESTDIR=/home/Jenkins-Build-Files/YellowHammer
BUILDDIR=${DESTDIR}/${year}/${month}-${dat}/${currtime}-${rev}-${branch}
# export $BUILDDIR
YHSERVER=$WORKSPACE/build/server/Release
YHWEBCLIENT=$WORKSPACE/build/webclient/${Release}
SSHDIR=/home/Jenkins-Build-Files/publish-over-ssh/yellowhammer-upgrade.zip

echo "[+] Checking for older file.."
if [ -f "${SSHDIR}" ]; then
    rm ${SSHDIR} > /dev/null 2>&1
    echo "${SSHDIR} removed"
fi

# --- End of Declaration Section ---    

if [[ ! -e $BUILDDIR ]]; then
    mkdir -p "${BUILDDIR}"
    #remove all folder and files older than 5 days
    echo "[+] Checking & removing files older than 5 days.."
    # sudo chown -R jenkins:jenkins ${DESTDIR}
    find ${DESTDIR}/ -mindepth 1 -mtime +5 -delete -print
else
    echo "${BUILDDIR} already exists" 1>&2
fi 

if [ -f "${WORKSPACE}/yellowhammer-upgrade.zip" ]; then
    echo "[-] Softlink to access yellowhammer-upgrade.zip file is already created"
else
    cd ${WORKSPACE} || exit 3
    ln -s ${SSHDIR} yellowhammer-upgrade.zip
    cd - > /dev/null 2>&1 || exit 3
    echo "[+] Created softlink to access yellowhammer-upgrade.zip file"    
fi

if [ ! -f "/home/jenkins/workspace/YellowHammer-Deployment-(Local-QA)/yellowhammer-upgrade.zip" ]; then
    ln -s ${SSHDIR} "/home/jenkins/workspace/YellowHammer-Deployment-(Local-QA)/yellowhammer-upgrade.zip" > /dev/null
fi
if [ ! -f "/home/jenkins/workspace/YellowHammer-Deployment-Prod/yellowhammer-upgrade.zip" ]; then
    ln -s ${SSHDIR} "/home/jenkins/workspace/YellowHammer-Deployment-Prod/yellowhammer-upgrade.zip" > /dev/null
fi
# --- Beginning of Collection Section ---

cd $YHWEBCLIENT || exit 3
echo "[+] Collecting WebClient"
#COLLECTING WEBCLIENT FILES
mkdir -p "${BUILDDIR}"/yellowhammer-webclient
zip -qr webapp.zip webapp/
cp webapp.zip yh-webclient-jar-with-dependencies.jar "${BUILDDIR}"/yellowhammer-webclient
mv "${BUILDDIR}"/yellowhammer-webclient/yh-webclient-jar-with-dependencies.jar "${BUILDDIR}"/yellowhammer-webclient/yh-webclient.jar
rm webapp.zip
cp -r i18n "${BUILDDIR}"/yellowhammer-webclient
cp -r logger "${BUILDDIR}"/yellowhammer-webclient

#collecting server files
cd ${YHSERVER}/${Release}/ || exit 3
mkdir -p "${BUILDDIR}"/yellowhammer-server/db-upgrade-scripts
echo "[+] Collecting YellowHammer-Server upgrade files"
cp ROOT.war ext_upgrade.properties "${BUILDDIR}"/yellowhammer-server

#Collecting database files
cp -r ${WORKSPACE}/build/server/yellowhammer/yellowhammer-base/scripts/*-db "${BUILDDIR}"/yellowhammer-server/db-upgrade-scripts
cd $YHSERVER/../ || exit 3
cd yellowhammer/yellowhammer-db/sqlite/ || exit 3
cp source_yellowhammer.db "${BUILDDIR}"/yellowhammer-server

#collecting CLI jar file
cd $WORKSPACE/build/cli/${CLI_Release}/ || exit 3
cp yellowhammer-cli-adaptor-*jar-with-dependencies.jar "${BUILDDIR}"/yellowhammer-server
echo ""
cd - > /dev/null 2>&1 || exit 3

#Saving yguard mapping
cp ${WORKSPACE}/build/server/Release/${Release}/yguard_mappings.log.xml "${BUILDDIR}"/yellowhammer-server

echo "[+] Compressing file for further operations.."
cd "${BUILDDIR}" || exit 3
zip -qr ${SSHDIR} yellowhammer-server/ yellowhammer-webclient/

echo "[+] Compressed files are available under ${SSHDIR}"
echo "[+] Build files are available under "${BUILDDIR}""
