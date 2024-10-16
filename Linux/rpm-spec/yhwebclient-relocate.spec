Name:       YellowHammer-WebClient
Version:    2
Release:    2
Summary:    YellowHammer-WebClient
License:    SigmaStream LLC

%description
YellowHammer-Webclient Package

Prefix: /home/sigmastream

%pre
#!/bin/sh
#-------------------------------------------ADD USER SECTION START----------------------------------------------
USERNAME=sigmastream
id -u $USERNAME > /dev/null 2>&1
if [ "$?" -ge 1 ]
then 
    echo "[+] Creating application user $USERNAME"
    /usr/sbin/useradd sigmastream  -c "SigmaStream product user"
    echo $USERNAME:SigmaStream#1 | chpasswd
    sudo usermod -a -G wheel $USERNAME
    sudo chmod -R 755 /home/sigmastream/
    # echo "[+] Created user $USERNAME [  OK  ]"
# else
    # echo "[-] Found application user $USERNAME - Done "
fi
echo "[+] Preparing files..."
#-------------------------------------------ADD USER SECTION FINISHED-------------------------------------------

%build
#Nothing here
#!/usr/bin/bash
#!/bin/bash/
#!/bin/sh

#--------------------------------------Started installation section-----------------------------------------------------
%install
echo "[+] Compressing files for build..."

#yhwebclient-2.0.7.GA - directory name
SRCDIR=home/sigmastream/yellowhammer/se

cd /home/centos/rpm/

zip -qr $SRCDIR/yhwebclient.zip $SRCDIR/yhwebclient-2.0.7.GA/ 

echo "[+] De-Compressing on build directory..."
unzip -q /home/centos/rpm/$SRCDIR/yhwebclient.zip  -d /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/

#Removing created zip file
rm /home/centos/rpm/$SRCDIR/yhwebclient.zip

echo "[+] Copying service files..."
cp -r /home/centos/rpm/etc /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/ > /dev/null

echo "[+] Copying java files..."
cp -r /home/centos/rpm/home/sigmastream/tmp /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/ > /dev/null

# rm /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/etc/init.d/yhserver
cd /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/etc/init.d/
ls | grep -v yhwebclient | xargs rm
cd -

#--------------------------------------End of installation section-----------------------------------------------------

#--------------------------------------Started files section-----------------------------------------------------
%files
%defattr(-, root, root, 0755)
# /home/sigmastream/yellowhammer/se/yhwebclient-2.0.7.GA/
%{prefix}/yellowhammer/se/yhwebclient-2.0.7.GA/
# /tmp/jdk1.8.0_51.tgz
# /etc/init.d/yhwebclient
#--------------------------------------End of files section-----------------------------------------------------

#--------------------------------------Started Post section-----------------------------------------------------------
%post
#!/bin/bash/
echo "[+] Starting Installation..."
#----------------------------Symbolic link creation part Started---------------------
if [ ! -d "/home/sigmastream/yhwebclient" ]
    then
        cd /home/sigmastream/
        ln -s /home/sigmastream/yellowhammer/se/yhwebclient-2.0.7.GA/ yhwebclient
        echo "[+] Creating Application Symbolic Link - Done"
    # else
        # echo "[-] Found YellowHammer-Webclient symbolic [  OK  ]"
fi

if [ ! -d "/apps/" ]
    then
        cd //
        ln -s /home/sigmastream/ apps
    # else
        # echo "[-] Found home directory symbolic link [  OK  ]"
fi

# echo "[+] Preparing Files..."
#---------------------------Symbolic link creation part Finished------------------------

#---------------------------File Extraction & Service start part------------------------
# echo "[+] Extracting system files..."
if [ ! -d "/home/sigmastream/jre" ]
    then
        cd /home/sigmastream/
        # rm /tmp/jdk1.8.0_51.tgz
        tar -xf /tmp/jdk1.8.0_51.tgz
        mv jdk1.8.0_51 jre
        echo "[+] Installing JAVA 1.8 Dependency - Done"
        rm /tmp/jdk1.8.0_51.tgz > /dev/null 2>&1
    # else
        # echo "[-] Found JAVA 1.8  [  OK  ]"
fi

#-----------------------File extraction part completed--------------------------------


# echo "[+] Starting YellowHammer-Webclient as a service..."
sudo systemctl daemon-reload
sudo service yhwebclient start > /dev/null 2>&1
sudo systemctl enable yhwebclient > /dev/null 2>&1
echo "[+] Installing YellowHammer-WebClient - Done"
sleep 5
echo ""
echo "###"
echo "[->] YellowHammer-WebClient Installation Path: /home/sigmastream/yhwebclient"
echo "[->] YellowHammer-WebClient Service Name: yhwebclient"
echo "[->] To Manage YellowHammer-WebClient Use: service yhwebclient start/stop/status"
echo "###"

# echo "Verify YellowHammer-WebClient Status : service yhwebclient status"
echo ""
echo "[+] Checking status of YellowHammer-WebClient..."
echo "[+] `exec sudo service yhwebclient status`"
sudo chown -R sigmastream:sigmastream /home/sigmastream/
sudo chmod -R 755 /home/sigmastream
ip=$(ifconfig | grep inet | awk '{print $2}' | head  -n 1)
sleep 5

# echo "###"
echo "-----------------------------------------------------------------"
echo "[->] YellowHammer-Webclient is running at - https://$ip:8447"
echo "-----------------------------------------------------------------"
# echo "###"
# echo "[+] Removing excess files"
# TO-DO
#Add curl coomand and check webclient is up or not if it's up then print server statted message.
# rm /jdk1.8.0_51.tgz
#-------------------------------------------End of %post macro-----------------------------------------------

#-------------------------------------Started Uninstallation section-------------------------------------------
%preun
echo "[+] Checking for running services..."
# echo "[+] Checking for running services..."
sudo service yhwebclient status > /dev/null 2>&1
if [ $? -eq 0 ]
    then 
        echo "[+] Stopping YellowHammer-WebClient service..."
        sudo service yhwebclient stop
else    
    echo "[-] YellowHammer-WebClient service is already stopped."
fi
#-------------------------------------End of Uninstallation section-------------------------------------------
%changelog
# *Tried to touch one file.
# let's skip this for now