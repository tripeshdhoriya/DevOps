#!/bin/bash
year=$(date +'%Y') 
month=$(date +'%m')
dat=$(date +'%d')
currtime=$(date +%H:%M)
WORKSPACE=/home/jenkins/workspace/BlueCardinal
DESTDIR=/home/Jenkins-Build-Files/BlueCardinal
BUILDDIR=${DESTDIR}/${year}/${month}-${dat}/${currtime} 
# export $BUILDDIR
# BCSERVER=$WORKSPACE/build-package
SSHDIR=/home/Jenkins-Build-Files/publish-over-ssh/

echo "[#] Checking for older file in the directory.."
if [ -f "${SSHDIR}/bluecardinal-*.jar" ]; then
    rm ${SSHDIR}/BlueCardinal-*.zip >/dev/null 2>&1
    rm ${SSHDIR}/bluecardinal-core*.jar >/dev/null 2>&1
    echo "${SSHDIR} removed"
fi

# --- End of Declaration Section ---    

if [ ! -d "${BUILDDIR}" ]; then
    mkdir -p "${BUILDDIR}"
else
    echo "${BUILDDIR} already exists" 1>&2
fi 

# --- Beginning of Collection Section ---    

#collecting server files
echo "[#] Compressing build-package..."
ver=$(cat ${WORKSPACE}/build-package/build.version)
dt=$(date +'%d%m')
cd ${WORKSPACE} || exit 3
zip -qr "${BUILDDIR}"/BlueCardinal-"${dt}"-"${ver}".zip build-package/
cp build-package/bluecardinal-core.jar "${BUILDDIR}"/bluecardinal-core-"${dt}"-"${ver}".jar
# mv bluecardinal-core.jar bluecardinal-core-${dt}-${ver}.jar
echo "[#] Moving compressed files for further process..."

#COPYING JAR FILE ONLY FOR BLUCARDINAL CONDITIONAL BUILD PURPOSE
cp "${BUILDDIR}"/BlueCardinal-"${dt}"-"${ver}".zip ${SSHDIR}
cp "${BUILDDIR}"/bluecardinal-core-"${dt}"-"${ver}".jar ${SSHDIR}
# echo "[+] Compressing file for further operations.."
cd ${WORKSPACE} || exit 3
hg tip | awk '{print $2}' | head -n 1 | cut -d ':' -f 1 > revision.txt
# cd ${BUILDDIR}
cd - > /dev/null 2>&1  || exit 3
# chown -R jenkins:jenkins ${BUILDDIR} ${SSHDIR}
echo "[#] Compressed files are available at ${SSHDIR}"
echo "[#] Build files are available at ${BUILDDIR}"