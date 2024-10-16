Name:       YellowHammer-WebClient
Version:    2
Release:    2
Summary:    YellowHammer-WebClient
License:    SigmaStream LLC

%description
YellowHammer-Webclient Package

%pre
#!/bin/sh
if [ -d /home ]; then
    diskspace=`df -m /home/ | grep % | tr -s " " | cut -d" " -f4 | tail -1`
    diskspace=`expr $diskspace / 1024`
    if [ $diskspace -lt 10 ]; then
        echo "[!] You have insufficient diskspace in the destination directory (/home/) to install this application, The installation requires at least 10 GB free space on this disk."
        exit 1
    fi
    else
        echo "[!] Can't find the destination directory (/home), EXITING"
fi

clear
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)



echo "
                                                                                                                    
      _/_/_/  _/                                        _/_/_/    _/                                                
   _/              _/_/_/  _/_/_/  _/_/      _/_/_/  _/        _/_/_/_/  _/  _/_/    _/_/      _/_/_/  _/_/_/  _/_/ 
    _/_/    _/  _/    _/  _/    _/    _/  _/    _/    _/_/      _/      _/_/      _/_/_/_/  _/    _/  _/    _/    _/
       _/  _/  _/    _/  _/    _/    _/  _/    _/        _/    _/      _/        _/        _/    _/  _/    _/    _/ 
_/_/_/    _/    _/_/_/  _/    _/    _/    _/_/_/  _/_/_/        _/_/  _/          _/_/_/    _/_/_/  _/    _/    _/  
                   _/                                                                                               
              _/_/                                 

"
# echo ""
#----------------------ADD USER SECTION START--------------------
USERNAME=sigmastream
id -u $USERNAME > /dev/null 2>&1
if [ "$?" -ge 1 ]
then 
    echo -n "[+] Creating application user $USERNAME"
    /usr/sbin/useradd sigmastream  -c "SigmaStream product user"
    echo $USERNAME:SigmaStream#1 | chpasswd
    sudo usermod -a -G wheel $USERNAME
    sudo chmod -R 755 /home/sigmastream/
    echo " [ $GREEN OK $NORMAL ]"
    # echo "[+] Created user $USERNAME [  OK  ]"
# else
    # echo "[-] Found application user $USERNAME - Done "
fi
echo -n "[+] Installing application..."
#----------------------ADD USER SECTION FINISHED-----------------

%build
#Nothing here
#!/usr/bin/bash
#!/bin/bash/
#!/bin/sh
#-------------------------------------------Starting of installation section------------------------------------------
%install
echo "[+] Compressing files for build..."

#yellowhammer-webclient - directory name
SRCDIR=home/sigmastream/yellowhammer/
cd /home/centos/rpm/

zip -qr $SRCDIR/yhwebclient.zip $SRCDIR/yellowhammer-webclient/ 

echo "[+] De-Compressing on build directory..."
# unzip -q /home/centos/rpm/$SRCDIR/yhwebclient.zip  -d /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/
unzip -q /home/centos/rpm/$SRCDIR/yhwebclient.zip  -d %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}


#Removing created zip file
rm /home/centos/rpm/$SRCDIR/yhwebclient.zip

echo "[+] Copying service files..."
# cp -r /home/centos/rpm/etc /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/etc %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

echo "[+] Copying java files..."
# cp -r /home/centos/rpm/home/sigmastream/tmp /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/home/sigmastream/tmp %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

# rm /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/etc/init.d/yhserver
# cd /root/rpmbuild/BUILDROOT/YellowHammer-WebClient-2-2.x86_64/etc/init.d/
cd %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/etc/init.d/
ls | grep -v yhwebclient | xargs rm
cd -
#---------------------------------------------End of installation section------------------------------------------

#-------------------------------------------Starting of file section-----------------------------------------------
%files
/home/sigmastream/yellowhammer/yellowhammer-webclient/
/tmp/jdk1.8.0_51.tgz
/etc/init.d/yhwebclient
#-------------------------------------------End of file section----------------------------------------------------

#-------------------------------------------Starting of post section-----------------------------------------------
%post
#!/bin/bash/
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
echo " [ $GREEN OK $NORMAL ]"
# echo "[+] Starting Installation..."
#------------------------Symbolic link creation part Started------------------------
if [ ! -d "/home/sigmastream/yhwebclient" ]
    then
        echo -n "[+] Creating application symbolic link... "
        cd /home/sigmastream/
        ln -s /home/sigmastream/yellowhammer/yellowhammer-webclient/ yhwebclient
        sudo chown -h sigmastream:sigmastream yhwebclient
        echo "[ $GREEN OK $NORMAL ]"
    # else
        # echo "[-] Found YellowHammer-Webclient symbolic [  OK  ]"
fi

if [ ! -d "/apps/" ]
    then
        cd //
        ln -s /home/sigmastream/ apps
        sudo chown -h sigmastream:sigmastream /apps
    # else
        # echo "[-] Found home directory symbolic link [  OK  ]"
fi

#-----------------------Symbolic link creation part Finished----------------------

#----------------------File Extraction & Service start part-----------------------
# echo "[+] Extracting system files..."
if [ ! -d "/apps/yhwebclient/jre" ]
    then
    echo -n "[+] Setting up Java 1.8 runtime..."
        cd /apps/yhwebclient/
        # rm /tmp/jdk1.8.0_51.tgz
        tar -xf /tmp/jdk1.8.0_51.tgz
        mv jdk1.8.0_51 jre
        echo " [ $GREEN OK $NORMAL ]"
        rm /tmp/jdk1.8.0_51.tgz > /dev/null 2>&1
        
    else
        echo "[+] Java 1.8 is already setup [ $GREEN OK $NORMAL ]"
fi

# echo "[+] Starting YellowHammer-Webclient as a service..."
sudo systemctl daemon-reload
# sudo service yhwebclient start > /dev/null 2>&1
sudo systemctl enable yhwebclient > /dev/null 2>&1
# echo "[+] Installing YellowHammer-WebClient - Done"

echo ""
echo "###"
echo "[#] Application name: YellowHammer-WebClient"
echo "[#] Application installation path: /home/sigmastream/yellowhammer/yellowhammer-webclient/"
echo "[#] Application log path: /home/sigmastream/yellowhammer/yellowhammer-webclient/logs/"
echo "[#] Application service name: yhwebclient"
echo "[#] Command(s) to manage application: sudo service yhwebclient [start|stop|status]"
echo "###"
echo ""
# echo "[+] Checking status of YellowHammer-WebClient..."
# echo "[+] `exec sudo service yhwebclient status`"
sudo chown sigmastream:sigmastream /home/sigmastream/yhwebclient/
sudo chown -R sigmastream:sigmastream /home/sigmastream/yellowhammer/
sudo chown sigmastream:sigmastream /etc/init.d/yhwebclient
sudo chmod -R 755 /home/sigmastream/yellowhammer/
ip=$(ifconfig | grep inet | awk '{print $2}' | head  -n 1)
sleep 5
#----------------------End of File Extraction & Service start part-----------------------
echo "-----------------------------------------------------------------------------------"
echo "[#] After starting service, you can access application at https://$ip:8447"
echo "-----------------------------------------------------------------------------------"

# TO-DO
#Add curl coomand and check webclient is up or not if it's up then print server statted message.
# rm /jdk1.8.0_51.tgz
#-------------------------------------------End of post section-----------------------------------------------

#-------------------------------------------Start of uninstallation section-----------------------------------
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
#-------------------------------------------End of uninstallation section-------------------------------------
%changelog
# *Tried to touch one file.
# let's skip this for now