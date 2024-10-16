#!/bin/bash
UPGRADEDIR=/home/sigmastream/Tools
YHSERVERDIR=/apps/yhserver
BACKUPDIR=${UPGRADEDIR}/Backup/YellowHammer-Server/
YHFULLPATH=/home/sigmastream/yellowhammer/se/
#from next release cat build.info file and use that number to create a tar file.
#UPDATING BUNDLE VERSION ON THIS BUILD FROM NEXT RELEASE USER yhserver-2.0.8.GA
BUNDLENAME=yhserver-2.0.8.GA
OLD_BACKUP=${BACKUPDIR}/YellowHammer-Server_13124.tar
BACKUPFILENAME=YellowHammer-Server_13248.tar
ZIPFILENAME=yellowhammer-server-upgrade.zip
#current release= 13840

GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

function checkdependency {
    unzip --help > /dev/null 2>&1
    if [ $? -eq 0 ]
        then 
        echo "[-] Required packages are already installed."
    else
        echo "[+] Installing unzip..."
        sudo yum install unzip -y || exit 3
        echo ""
    fi
}

function stopservice {
    sudo service yhserver status > /dev/null 2>&1
    if [ $? -eq 0 ]
        then 
            echo "[+] Stopping YellowHammer-Server service."
            sudo service yhserver stop > /dev/null 2>&1
            sleep 5
            sudo kill -9 "$(pgrep -f "/apps/yhserver")" > /dev/null 2>&1
            sudo kill -9 "$(pgrep -f "/apps/yhserver")" > /dev/null 2>&1
    else    
        echo "[-] YellowHammer-Server is already stopped."
    fi
}

function takebackup {
    #---------------Taking Backup----------------------x
    sudo su sigmastream -c "mkdir -p ${BACKUPDIR} > /dev/null 2>&1"
    if [ -f "${BACKUPDIR}/${BACKUPFILENAME}" ]; then
        echo "[#] Backup file already exists."
    else
        #create tar file by excluding the log directory
        echo -n "[+] Taking backup, this may take upto five minutes.. "
        if [ -f ${BACKUPDIR}/${OLD_BACKUP} ]; then
            sudo rm ${BACKUPDIR}/${OLD_BACKUP} > /dev/null 2>&1
        fi
        cd ${YHFULLPATH} || exit 3; sudo su sigmastream -c "tar --exclude=${BUNDLENAME}/yellowhammer-base/logs --exclude=${BUNDLENAME}/logs -zcf ${BACKUPDIR}/${BACKUPFILENAME} ${BUNDLENAME}"; cd - > /dev/null 2>&1 || exit 3
        echo " [ $GREEN OK $NORMAL ]"
    fi
    #--------------------xxxxxx-------------------------x
}

function restorebackup {
    read -p "[!] Are you sure? It is adviced to consult SigmaStream Support before rolling back to previous version. @[support@sigmastream.com]. (Press 'y,Y' to continue, press other key to exit): " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ -f ${BACKUPDIR}/${BACKUPFILENAME} ]; then
            stopservice
            echo -n "[+] Unrolling backup files.."
            sudo su sigmastream -c "tar -xf ${BACKUPDIR}/${BACKUPFILENAME} -C ${YHFULLPATH}"
            sudo su sigmastream -c "mkdir -p ${YHFULLPATH}/${BUNDLENAME}/yellowhammer-base/logs/"
            sudo su sigmastream -c "mkdir -p ${YHFULLPATH}/${BUNDLENAME}/logs/"
            echo " [ $GREEN OK $NORMAL ]"
            #recreating ROOT folder and touch root.war
            cd ${YHSERVERDIR}/yellowhammer-base/webapps/ || exit 3 ; sudo rm -rf ROOT; sudo su sigmastream -c "mkdir ROOT"; sleep 1 ; sudo su sigmastream -c "touch ROOT.war"
            if [ $? -eq 0 ]; then
                echo " [ $GREEN OK $NORMAL ]"
                sudo service yhserver start
                cd - ||exit 0 > /dev/null 2>&1
            else
                echo "[!] Something went wrong while touching war file."
            fi
        else
            echo "[!] No backup file found at ${BACKUPDIR}/${BACKUPFILENAME}"
        fi
    fi
}

if [ -z "$1" ]; then
    if [ -f ${ZIPFILENAME} ]; then
        sudo mkdir -p ${UPGRADEDIR} > /dev/null 2>&1
        #Dependency Check
        checkdependency
        sudo unzip -q ${ZIPFILENAME} -d ${UPGRADEDIR}

        if [ -d ${UPGRADEDIR}/yellowhammer-server/ ]; then 

            #yhserver update
            stopservice
            #taking backup
            takebackup
            # ---------------------------------------

            cd ${UPGRADEDIR}/yellowhammer-server/ || exit 3
            
            echo -n "[+] Upgrading YellowHammer-Server..."
            #replace yellowhammer-base files
            cd ${UPGRADEDIR}/yellowhammer-server/yellowhammer-base/ || exit 3

            #append config changes
            sudo cat config-ext.properties >> ${YHSERVERDIR}/yellowhammer-base/config-ext.properties
            ###

            ##Logger change
            # sudo mv ${YHSERVERDIR}/yellowhammer-base/logger/log4j2.properties ${YHSERVERDIR}/yellowhammer-base/logger/_log4j2-properties
            # sudo cp log4j2.properties ${YHSERVERDIR}/yellowhammer-base/logger/
            ###

            #apply db upgrade
            if [ ! -f  ${YHSERVERDIR}/yellowhammer-base/patches/subscription_channel_source.sql ]; then
                sudo cp subscription_channel_source.sql $YHSERVERDIR/yellowhammer-base/deploy/
                sudo cp device_channel_upgrade_source.sql $YHSERVERDIR/yellowhammer-base/deploy/
            #     # sudo cp subscription_channel_upgrade_source.sql $YHSERVERDIR/yellowhammer-base/
            fi
            
            ###
            
            #replacing root.war
            sudo rm -rf ${YHSERVERDIR}/yellowhammer-base/webapps/
            sudo cp -r webapps/ ${YHSERVERDIR}/yellowhammer-base/
            sleep 2
            sudo touch ${YHSERVERDIR}/yellowhammer-base/webapps/ROOT.war
            sleep 2
            echo " [ $GREEN OK $NORMAL ]"
            ###

            #Cleaning old logs.
            echo -n "[+] Cleaning old logs... "
            sudo rm ${YHSERVERDIR}/logs/gc-* > /dev/null 2>&1
            sudo rm ${YHSERVERDIR}/heapdump/*.hprof > /dev/null 2>&1
            sudo rm ${YHSERVERDIR}/yellowhammer-base/logs/*.log* > /dev/null 2>&1
            echo " [ $GREEN OK $NORMAL ]"
            sudo chown -R sigmastream:sigmastream /apps/yhserver/
            ###

            cd ${UPGRADEDIR} > /dev/null 2>&1 || exit 3
            sudo rm -rf yellowhammer-server > /dev/null 2>&1

            # echo " [ $GREEN OK $NORMAL ]"

            #Starting services... [optional]
            echo "[+] Attempting to start YellowHammer-Server..."
            sudo service yhserver start
            # echo " [ $GREEN OK $NORMAL ]"
            sleep 3
            sudo chown -R sigmastream:sigmastream ${UPGRADEDIR}/
        else
            echo "[#] Couldn't find yellowhammer-server upgrade files at ${UPGRADEDIR}"
        fi
    else
        echo "[#] Couldn't file ${ZIPFILENAME} file on current directory."
    fi

elif [ "$1" == "rollback" ]; then
    #restoring backup
    restorebackup
else
    echo "[#] Unsupported parameter. [ Giving no parameters will update the YelllowHammer-Server | Use 'rollback' to jump to the previous build. ] "
fi