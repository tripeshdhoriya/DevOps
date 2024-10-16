#!/bin/bash
year=$(date +'%Y') 
month=$(date +'%m')
dat=$(date +'%d')
currtime=$(date +%H:%M)
WORKSPACE=/home/jenkins/workspace/BlueCardinal-Conditional

cd ${WORKSPACE}  || exit 3
hg tip | awk '{print $2}' | head -n 1 | cut -d ':' -f 1 > revision.txt
rev=$(hg tip | awk '{print $2}' | head -n 1 | cut -d ':' -f 1)
cd - > /dev/null 2>&1  || exit 3

DESTDIR=/home/Jenkins-Build-Files/BlueCardinal
BUILDDIR=${DESTDIR}/${year}/${month}-${dat}/${currtime}-${rev}
# export $BUILDDIR
# BCSERVER=$WORKSPACE/build-package
SSHDIR=/home/Jenkins-Build-Files/publish-over-ssh

echo "[#] Checking for older jar in the directory.."
OLDJAR=$(ls ${SSHDIR}/blue*.jar)
if [[ -n ${OLDJAR} ]]; then
    cd ${SSHDIR}/  || exit 3
    rm bluecardinal*.jar
    rm BlueCardinal*.zip >/dev/null 2>&1
    cd - >/dev/null 2>&1  || exit 3
    # rm ${SSHDIR}/*.jar 
    echo "${SSHDIR} old jar/zip removed"
fi

# --- End of Declaration Section ---    

if [[ ! -e $BUILDDIR ]]; then
    mkdir -p "${BUILDDIR}"
    #remove all files older than 5 days
    find ${DESTDIR}/ -mindepth 1 -mtime +5 -delete -print
elif [[ ! -d "${BUILDDIR}" ]]; then
    echo "${BUILDDIR} already exists" 1>&2
fi 

# --- Beginning of Collection Section ---    

#collecting server files
echo "[#] Compressing build-package..."
ver=$(cat ${WORKSPACE}/build-package/build.version)
dt=$(date +'%d%m')
cd ${WORKSPACE}  || exit 3
rm ./*.jar
branch=$(hg branch)
# zip -qr ${BUILDDIR}/BlueCardinal-${dt}-${ver}.zip build-package/
cp bluecardinal-engine/bluecardinal-core.jar "${BUILDDIR}"/bluecardinal-core-"${branch}"-"${dt}"-"${ver}".jar
# mv bluecardinal-core.jar bluecardinal-core-${dt}-${ver}.jar
echo "[#] Moving compressed files for further process..."

#COPYING JAR FILE ONLY FOR BLUCARDINAL CONDITIONAL BUILD PURPOSE
# cp ${BUILDDIR}/BlueCardinal-${branch}-${dt}-${ver}.zip ${SSHDIR}
cp "${BUILDDIR}"/bluecardinal-core-"${branch}"-"${dt}"-"${ver}.jar" ${SSHDIR}
cp "${BUILDDIR}"/bluecardinal-core-"${branch}"-"${dt}"-"${ver}.jar" ${WORKSPACE}
# echo "[+] Compressing file for further operations.."
# cd ${BUILDDIR}
cd - > /dev/null >&1 || exit 3
# chown -R jenkins:jenkins ${BUILDDIR} ${SSHDIR}
echo "[#] Jar file is available at ${SSHDIR}"
echo "[#] Jar file is available at ${BUILDDIR}"