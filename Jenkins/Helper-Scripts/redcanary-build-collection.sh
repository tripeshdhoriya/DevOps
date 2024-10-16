#!/bin/bash
year=$(date +'%Y') 
month=$(date +'%m')
dat=$(date +'%d')
currtime=$(date +%H:%M)
WORKSPACE=/home/jenkins/workspace/RedCanary

cd ${WORKSPACE}
hg tip | awk '{print $2}' | head -n 1 | cut -d ':' -f 1 > revision.txt
rev=`hg tip | awk '{print $2}' | head -n 1 | cut -d ':' -f 1`
cd - > /dev/null 2&>1 

DESTDIR=/home/Jenkins-Build-Files/RedCanary
BUILDDIR=${DESTDIR}/${year}/${month}-${dat}/${currtime}-${rev}
RCBUILD=$WORKSPACE/build/
# RCAGENT=$WORKSPACE/build/agent
SSHDIR=/home/Jenkins-Build-Files/publish-over-ssh/redcanary-bundle.zip

echo "[+] Checking for older file.."
if [ -f "${SSHDIR}" ]; then
    rm ${SSHDIR} > /dev/null 2>&1
    echo "${SSHDIR} removed"
fi

# check if we are being sourced by another script or shell
# [[ "${#BASH_SOURCE[@]}" -gt "1" ]] && { return 0; }

# --- End of Declaration Section ---    

if [[ ! -e $BUILDDIR ]]; then
    mkdir -p ${BUILDDIR}
    #remove all folder and files older than 5 days
    find ${DESTDIR}/ -mindepth 1 -mtime +5 -delete -print
elif [[ ! -d $dir ]]; then
    echo "${BUILDDIR} already exists" 1>&2
fi 

# --- Beginning of Collection Section ---    

#Collecting RedCanary-Agent
echo "[+] Collecting RedCanary-Agent files.."
cd ${RCBUILD}
zip -qr ${BUILDDIR}/RedCanary-Agent.zip agent/
cp agent/rc-agent-2.2.1.jar ${BUILDDIR}

#collecting server files
echo "[+] Collecting RedCanary-Server files.."
zip -qr ${BUILDDIR}/RedCanary-Server.zip server/
cp server/rc-server-2.2.1-jar-with-dependencies.jar ${BUILDDIR}
echo ""

echo "[+] Compressing file for further operations.."
cd ${BUILDDIR}
zip -q ${SSHDIR} RedCanary-Server.zip RedCanary-Agent.zip

cd ${WORKSPACE}
hg tip | awk '{print $2}' | head -n 1 | cut -d ':' -f 1 > revision.txt

cd - > /dev/null 2>&1
echo "[#] Compressed files are available under ${SSHDIR}"
echo "[#] Build files are available under ${BUILDDIR}"