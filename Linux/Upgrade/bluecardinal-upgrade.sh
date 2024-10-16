#!/bin/bash
UPGRADEDIR=/home/sigmastream/Tools
BCSERVERDIR=/apps/bcserver
BACKUPDIR=${UPGRADEDIR}/Backup/BlueCardinal-Server
BCFULLPATH=/home/sigmastream/bluecardinal
#from next release cat build.info file and use that number to create a tar file.
BUNDLENAME=bc_release-1.2.0
ZIPFILENAME=bluecardinal-upgrade.zip
OLD_BACKUP=${BACKUPDIR}/BlueCardinal-Server_1042.tar
BACKUPFILENAME=BlueCardinal-Server_1091.tar
#current-release-1097

GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

function stopservice {

    #bluecardinal service check
    # echo "[+] Checking for running services..."
    sudo service bluecardinal status > /dev/null 2>&1
    if [ $? -eq 0 ]; then 
            echo "[+] Stopping running BlueCardinal-Server service."
            sudo service bluecardinal stop > /dev/null 2>&1
            sleep 5
    else    
        echo "[-] BlueCardinal-Server is already stopped."
    fi
}

function takebackup {

        #---------------Taking Backup----------------------x
        sudo su sigmastream -c "mkdir -p ${BACKUPDIR} > /dev/null 2>&1"
        if [ -f "${BACKUPDIR}/${BACKUPFILENAME}" ]; then
            echo "[#] Backup file already exists."
        else
            if [ -f ${OLD_BACKUP} ]; then
                # echo "[+] Removing oldest backup file."
                sudo rm ${OLD_BACKUP}
            fi
            #create tar file by excluding the log directory
            echo -n "[+] Taking backup, this may take upto two minute.. "
            cd ${BCFULLPATH} || exit 3; sudo su sigmastream -c "tar --exclude=${BUNDLENAME}/bin/dq -zcf ${BACKUPDIR}/${BACKUPFILENAME} ${BUNDLENAME}"; cd - > /dev/null 2>&1 || exit 3
            echo " [ $GREEN OK $NORMAL ]"
        fi
        #--------------------xxxxxx-------------------------x

}

function restorebackup {

    read -p "[!] Are you sure? It is adviced to consult SigmaStream Support before rolling back to previous version @[support@sigmastream.com]. (Press 'y,Y' to continue, press other key to exit): " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if [ -f ${BACKUPDIR}/${BACKUPFILENAME} ]; then
            stopservice
            echo -n "[+] Unrolling backup files.."
            # cd ${BACKUPDIR} || exit 3; gunzip ${BACKUPFILENAME}
            sudo su sigmastream -c "tar -xf ${BACKUPDIR}/${BACKUPFILENAME} -C ${BCFULLPATH}"
            if [ $? -eq 0 ]; then 
                echo " [ $GREEN OK $NORMAL ]"
                sudo service bluecardinal start
            else
                echo "[!] Something went wrong while restoring backup."
            fi
        else
            echo "[!] No backup file found at ${BACKUPDIR}/${BACKUPFILENAME}"
        fi
    fi
}
if [ -z $1 ]; then

    if [ -f ${ZIPFILENAME} ]; then

        #unzip
        sudo mkdir -p /home/sigmastream/Tools/ > /dev/null 2>&1
        # echo "[#] Checking for required packages [zip,unzip]"
        unzip --help > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "[-] Required packages are already installed."
        else
            echo "[+] Installing unzip..."
            sudo yum install unzip -y || exit 1
            echo ""
        fi
        sudo unzip -q ${ZIPFILENAME} -d ${UPGRADEDIR}/

        if [ -d ${UPGRADEDIR}/bluecardinal-server/ ]; then 
        stopservice
        #---------------Taking Backup----------------------x
        takebackup
        #--------------------xxxxxx-------------------------
        sudo echo "1097" > ${BCSERVERDIR}/build.info > /dev/null 2>&1

        echo -n "[+] Adjusting config files... "
        
        #Upgrade bluecardinal-server
        cd $UPGRADEDIR || exit 3
        cd bluecardinal-server/ || exit 3

        #Replacing core jar file
        sudo rm ${BCSERVERDIR}/old-bluecardinal-core-jar > /dev/null 2>&1
        sudo mv ${BCSERVERDIR}/bluecardinal-core.jar ${BCSERVERDIR}/old-bluecardinal-core-jar
        sudo cp bluecardinal-core.jar ${BCSERVERDIR}

        #adjusting config
        sudo mkdir ${BCSERVERDIR}/bak_config > /dev/null 2>&1

        #cleaning config dir
        sudo rm ${BCSERVERDIR}/bak_config/W121LS_operator-dataquality-extended-ML.config > /dev/null 2>&1
        sudo rm ${BCSERVERDIR}/bak_config/W121LS_config_operator-dataquality-extended-SLS.config > /dev/null 2>&1
        sudo rm ${BCSERVERDIR}/bak_config/W121LS_operator-well-operational-121LS.config > /dev/null 2>&1
        sudo mv ${BCSERVERDIR}/config/operator-dataquality-extended-ML.config ${BCSERVERDIR}/bak_config/logic_error_operator-dataquality-extended-ML.config > /dev/null 2>&1
        sudo mv ${BCSERVERDIR}/config/operator-dataquality-extended-SLS.config ${BCSERVERDIR}/bak_config/logic_error_operator-dataquality-extended-SLS.config > /dev/null 2>&1
        sudo mv ${BCSERVERDIR}/config/operator-well-operational-121LS.config ${BCSERVERDIR}/bak_config/freq_issue_operator-well-operational-121LS.config > /dev/null 2>&1
        sudo mv ${BCSERVERDIR}/config/operator-dataquality.config ${BCSERVERDIR}/bak_config/ > /dev/null 2>&1

        #adding new configs
        sudo cp ./config/operator-well-operational-121LS.config ${BCSERVERDIR}/config/
        sudo cp ./config/operator-dataquality-extended-ML.config ${BCSERVERDIR}/deploy/
        sudo cp ./config/operator-dataquality-extended-SLS.config ${BCSERVERDIR}/deploy/

        echo " [ $GREEN OK $NORMAL ]"
        echo -n "[+] Cleaning old logs... "
        sudo rm ${BCSERVERDIR}/logs/bluecardinal* > /dev/null 2>&1
        sudo rm ${BCSERVERDIR}/heapdump/bcserver.hprof > /dev/null 2>&1
        sudo rm ${BCSERVERDIR}/logs/gc-* > /dev/null 2>&1
        sudo rm ${BCSERVERDIR}/AppData/* > /dev/null 2>&1
        echo " [ $GREEN OK $NORMAL ]"

        #Restoring permissions
        sudo chown -R sigmastream:sigmastream ${BCSERVERDIR}/
  
        cd ${UPGRADEDIR} || exit 1 > /dev/null 2>&1

        sudo rm -rf bluecardinal-server > /dev/null 2>&1

        #Starting services... [optional]
        echo "[+] Attempting to restart BlueCardinal Service..."
        sudo service bluecardinal start
        #fixing permissions on tools directory.
        sudo chown -R sigmastream:sigmastream /home/sigmastream/Tools/
        else
            echo "[#] Couldn't find upgrade files at ${UPGRADEDIR}"
        fi
    else
        echo "[#] Couldn't find ${ZIPFILENAME} file on current directory."
    fi

elif [ $1 == "rollback" ]; then
    restorebackup
    # echo "[!] Rollback isn't supported for this patch."
else
    echo "[#] Unsupported parameter. [Giving no parameters will update the BlueCardinal-Server | Use 'rollback' to jump to the previous build.] "
fi