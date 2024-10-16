#!/bin/bash
UPGRADEDIR=/home/sigmastream/Tools
YHWEBCLIENTDIR=/apps/yhwebclient
BACKUPDIR=${UPGRADEDIR}/Backup/YellowHammer-WebClient/
YHFULLPATH=/home/sigmastream/yellowhammer/se/
#from next release cat build.info file and use that number to create a tar file.
OLD_BACKUP=${BACKUPDIR}/YellowHammer-WebClient_13124.tar
BACKUPFILENAME=YellowHammer-WebClient_13248.tar
#UPDATING BUNDLE VERSION ON THIS BUILD FROM NEXT RELEASE USER yhserver-2.0.8.GA
BUNDLENAME=yhwebclient-2.0.8.GA
ZIPFILENAME=yellowhammer-webclient-upgrade.zip
#Current Release= 13840

GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)

function checkdependency {
    unzip --help > /dev/null 2>&1
    if [ $? -eq 0 ]
        then 
        echo "[-] Required packages are already installed."
    else
        echo "[+] Installing unzip..."
        sudo yum install unzip -y || exit 1
        echo ""
    fi
}

function stopservice {

    # echo "[+] Checking for running services..."
    sudo service yhwebclient status > /dev/null 2>&1
    if [ $? -eq 0 ]
        then 
            echo "[+] Stopping YellowHammer-Webclient service."
            sudo service yhwebclient stop > /dev/null 2>&1
            sleep 5
    else    
        echo "[-] YellowHammer-Webclient is already stopped."
    fi
}

function takebackup {
    sudo su sigmastream -c "mkdir -p ${BACKUPDIR}" > /dev/null 2>&1
    if [ -f "${BACKUPDIR}/${BACKUPFILENAME}" ]; then
        echo "[#] Backup file already exists."
    else
        sudo su sigmastream -c "mkdir -p ${BACKUPDIR} "
        if [ -f ${OLD_BACKUP} ]; then
            sudo rm ${OLD_BACKUP} > /dev/null 2>&1
        fi
        #create tar file by excluding the log directory
        echo -n "[+] Taking backup, this may take upto two minute.. "
        cd ${YHFULLPATH} || exit 3; sudo su sigmastream -c "tar -zcf ${BACKUPDIR}/${BACKUPFILENAME} ${BUNDLENAME}"; cd - > /dev/null 2>&1 || exit 3
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
            sudo su sigmastream -c "tar -xf ${BACKUPDIR}/${BACKUPFILENAME} -C ${YHFULLPATH}"
            if [ $? -eq 0 ]; then 
                echo " [ $GREEN OK $NORMAL ]"
                sudo service yhwebclient start
            else
                echo "[!] Something went wrong while unrolling the backup."
            fi
        else
            echo "[!] No backup file found at ${BACKUPDIR}/${BACKUPFILENAME}"
        fi
    fi
}

if [ -z "$1" ]; then

    if [ -f ${ZIPFILENAME} ]; then

        sudo mkdir -p ${UPGRADEDIR} > /dev/null 2>&1
        #CHECK FOR EXISTING INSTALLATION OF THIS PACAKGE.
        checkdependency
        sudo unzip -q ${ZIPFILENAME} -d $UPGRADEDIR

        if [ -d $UPGRADEDIR/yellowhammer-webclient/ ]; then 

            #yhwebclient update
            stopservice
            #Taking Backup and removing oldest backup
            takebackup

            echo  -n "[+] Upgrading YellowHammer-WebClient..."
            cd $UPGRADEDIR/yellowhammer-webclient || exit 3

            #upgrading jar & webapp
            sudo rm -rf $YHWEBCLIENTDIR/webapp
            sudo unzip -q webapp.zip -d $YHWEBCLIENTDIR
            
            #remove old jar incase exists
            sudo rm $YHWEBCLIENTDIR/yh-webclient-old-jar > /dev/null 2>&1
            sudo mv -f $YHWEBCLIENTDIR/yh-webclient.jar $YHWEBCLIENTDIR/yh-webclient-old-jar
            sudo cp yh-webclient.jar $YHWEBCLIENTDIR
            sudo rm $YHWEBCLIENTDIR/webapp-* > /dev/null 2>&1
            sudo rm $YHWEBCLIENTDIR/yh-webclient-* > /dev/null 2>&1
            #----#

            #copying i18n message files
            sudo rm -rf $YHWEBCLIENTDIR/i18n/
            sudo cp -r i18n/ $YHWEBCLIENTDIR/

            #Append config
            # sudo cat config.properties >> $YHWEBCLIENTDIR/config/config.properties
            echo " [ $GREEN OK $NORMAL ]"

            #Cleaning old logs.
            echo -n "[+] Cleaning old logs... "
            sudo rm ${YHWEBCLIENTDIR}/logs/*.log* > /dev/null 2>&1
            sudo rm ${YHWEBCLIENTDIR}/heapdump/*.hprof > /dev/null 2>&1
            echo " [ $GREEN OK $NORMAL ]"

            ##Fixing permissions
            sudo chown -R sigmastream:sigmastream /apps/yhwebclient/

            cd $UPGRADEDIR > /dev/null 2>&1 || exit 3
            sudo rm -rf yellowhammer-webclient > /dev/null 2>&1

            #Starting services... [optional]
            echo -n "[+] Attempting to start YellowHammer-WebClient..."
            sudo service yhwebclient start > /dev/null 2>&1
            sleep 5
            sudo chown -R sigmastream:sigmastream $UPGRADEDIR
            echo " [ $GREEN OK $NORMAL ]"
        else
            echo "[#] Couldn't find yellowhammer-webclient upgrade files at $UPGRADEDIR"
        fi
    else
        echo "[#] Couldn't find ${ZIPFILENAME} file on current directory."
    fi

elif [ $1 == "rollback" ]; then
    restorebackup
else
    echo "[#] Unsupported parameter. [ Giving no parameters will update the YelllowHammer-WebClient | Use 'rollback' to jump to the previous build. ] "
fi