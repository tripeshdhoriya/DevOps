#!/bin/bash

shopt -s expand_aliases
source ~/.bashrc

YHSERVERDESTDIR=/home/sigmastream/yhserver/yellowhammer-base/webapps/
YHWEBDESTDIR=/home/sigmastream/yhwebclient/
buildlocation=/home/Jenkins-Build-Files/publish-over-ssh/
deploybuildfilename=yellowhammer-upgrade.zip

if [ -f ${buildlocation}/${deploybuildfilename} ]; then
    echo "[+] Checking status of YellowHammer-Server service..."
    sudo service yhserver status > /dev/null 2>&1
    if [ $? -eq 0 ]
        then 
            echo "[+] Stopping YellowHammer-Server service..."
            sudo service yhserver stop
    else    
        echo "[-] YellowHammer-Server service is already stopped."
    fi

    echo "[+] Checking status of YellowHammer-Webclient service..."
    sudo service yhwebclient status > /dev/null 2>&1
    if [ $? -eq 0 ]
        then 
            echo "[+] Stopping YellowHammer-WebClient service..."
            sudo service yhwebclient stop
    else    
        echo "[-] YellowHammer-WebClient service is already stopped."
    fi

    wait
    echo "[+] De-compressing files..."
    cd ${buildlocation} || exit 1
    unzip -oq ${deploybuildfilename}
    echo "[+] Upgrading YH-SERVER files..."
    sudo rm ${YHSERVERDESTDIR}/ROOT.war
    sudo cp yellowhammer-server/ROOT.war ${YHSERVERDESTDIR}
    
    if [[ -d "${YHSERVERDESTDIR}/ROOT" ]]
    then
        echo "found old ROOT directory removing it."
        cd ${YHSERVERDESTDIR} || exit 1
        sudo rm -rf ./ROOT
        mkdir ROOT
        cd - || exit 1
    fi
    echo  "Updating time for ROOT.war"
    cd ${YHSERVERDESTDIR} || exit 1
    sleep 2
    touch ROOT.war
    cd - || exit 1
    echo ""

    echo "[+] Upgrading YH-WEBCLIENT files..."
    sudo rm ${YHWEBDESTDIR}/yh-webclient.jar
    sudo cp yellowhammer-webclient/yh-webclient.jar ${YHWEBDESTDIR}
    unzip -oq yellowhammer-webclient/webapp.zip -d ${YHWEBDESTDIR}

    wait

    echo "[+] Removing build files..."
    cd ${buildlocation} || exit 1
    # rm yellowhammer-upgrade.zip
    sudo rm -rf ./yellowhammer-server
    sudo rm -rf ./yellowhammer-webclient

    sudo service yhserver start
    sudo service yhwebclient start
else
    echo "[+] Upgrade zip file not found."
fi