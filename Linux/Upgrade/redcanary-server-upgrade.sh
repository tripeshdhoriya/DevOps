#!/bin/bash
UPGRADEDIR=/home/sigmastream/Tools
RCSERVERDIR=/apps/rcserver
BACKUPDIR=${UPGRADEDIR}/Backup/RedCanary-Server/
RCFULLPATH=/home/sigmastream/redcanary/
#from next release cat build.info file and use that number to create a tar file.
#UPDATING BUNDLE VERSION ON THIS BUILD FROM NEXT RELEASE USER rc-server-2.0.0
BUNDLENAME=rc-server-2.0.0
OLD_BACKUP=${BACKUPDIR}/RedCanary-Server_985.tar
BACKUPFILENAME=RedCanary-Server_985.tar
ZIPFILENAME=redcanary-server-upgrade.zip
#current release= 

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
    sudo service rcserver status > /dev/null 2>&1
    if [ $? -eq 0 ]
        then 
            echo "[+] Stopping RedCanary-Server service."
            sudo service rcserver stop > /dev/null 2>&1
            sleep 5
            sudo kill -9 "$(pgrep -f "/apps/rcserver")" > /dev/null 2>&1
            sudo kill -9 "$(pgrep -f "/apps/rcserver")" > /dev/null 2>&1
    else    
        echo "[-] RedCanary-Server is already stopped."
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
        cd ${RCFULLPATH} || exit 3; sudo su sigmastream -c "tar --exclude=${BUNDLENAME}/logs -zcf ${BACKUPDIR}/${BACKUPFILENAME} ${BUNDLENAME}"; cd - > /dev/null 2>&1 || exit 3
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
            sudo su sigmastream -c "tar -xf ${BACKUPDIR}/${BACKUPFILENAME} -C ${RCFULLPATH}"
            sudo su sigmastream -c "mkdir -p ${RCFULLPATH}/${BUNDLENAME}/logs/"
            if [ $? -eq 0 ]; then
                echo " [ $GREEN OK $NORMAL ]"
                sudo service rcserver start
                cd - ||exit 0 > /dev/null 2>&1
            else
                echo "[!] Something went wrong while creating logs directory."
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

        if [ -d ${UPGRADEDIR}/redcanary-server/ ]; then 

            #rcserver update
            stopservice
            #taking backup
            takebackup
            # ---------------------------------------

            cd ${UPGRADEDIR}/redcanary-server/ || exit 3
            
            echo -n "[+] Upgrading RedCanary-Server..."
            
            cd ${UPGRADEDIR}/redcanary-server/ || exit 3

            #append config changes
            sudo cat config.properties >> ${RCSERVERDIR}/config/config.properties
            ###

            #upgrading jar & webapp
            sudo rm -rf ${RCSERVERDIR}/webapp
            sudo unzip -q webapp.zip -d ${RCSERVERDIR}/

            ##jar change
            sudo mv ${RCSERVERDIR}/rc-server.jar ${RCSERVERDIR}/rc-server.jar
            sudo cp rc-server.jar ${RCSERVERDIR}/
            ###

            
            #Cleaning old logs.
            echo -n "[+] Cleaning old logs... "
            sudo rm ${RCSERVERDIR}/logs/*.log* > /dev/null 2>&1
            sudo rm ${RCSERVERDIR}/heapdump/*.hprof > /dev/null 2>&1
            sudo rm ${RCSERVERDIR}/startup.log > /dev/null 2>&1
            echo " [ $GREEN OK $NORMAL ]"
            sudo chown -R sigmastream:sigmastream /apps/rcserver/
            ###

            cd ${UPGRADEDIR} > /dev/null 2>&1 || exit 3
            sudo rm -rf redcanary-server > /dev/null 2>&1

            # echo " [ $GREEN OK $NORMAL ]"

            #Starting services... [optional]
            echo "[+] Attempting to start RedCanary-Server..."
            sudo service rcserver start
            # echo " [ $GREEN OK $NORMAL ]"
            sleep 3
            sudo chown -R sigmastream:sigmastream ${UPGRADEDIR}/
        else
            echo "[#] Couldn't find RedCanary-Server upgrade files at ${UPGRADEDIR}"
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