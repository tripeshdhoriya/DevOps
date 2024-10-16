Name:       BlueCardinal-Server
Version:    2
Release:    2
Summary:    BlueCardinal-Server
License:    SigmaStream LLC

%description
BlueCardinal-Engine Package

%pre
#!/bin/bash
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
    # adduser sigmastream  -d /home/sigmastream/ --shell /bin/bash -c "SigmaStream product user"
    /usr/sbin/useradd sigmastream  -c "SigmaStream product user"
    echo $USERNAME:SigmaStream#1 | chpasswd
    sudo usermod -a -G wheel $USERNAME
    sudo chmod -R 755 /home/sigmastream
    echo " [ $GREEN OK $NORMAL ]"
    # echo "[+] Application user $USERNAME is created  -"
# else
    # echo "[-] Application user $USERNAME found."
fi
echo -n "[+] Installing application..."
#----------------------ADD USER SECTION FINISHED-----------------


%build
#Nothing here
#-------------------------------------------Starting of installation section------------------------------------------
%install
#!/bin/bash
echo "[+] Compressing files for build..."
cd /home/centos/rpm/
#yhsource-2.0.7.GA - directory name
SRCDIR=home/sigmastream/bluecardinal
FOLDER_1=bluecardinal-server/
# FOLDER_2=bluecardinal-webclient

# zip -rq $SRCDIR/bluecardinal.zip $SRCDIR/$FOLDER_NAME
tar -zcf $SRCDIR/bluecardinal.tar $SRCDIR/$FOLDER_1 & 
# tar -zcf $SRCDIR/bluecardinal-webclient.tar $SRCDIR/$FOLDER_2 &
wait
# cp  $SRCDIR/bluecardinal.tar /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/ 
cp  $SRCDIR/bluecardinal.tar %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}  &
# cp  $SRCDIR/bluecardinal-webclient.tar %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}  &
wait
echo "[+] De-Compressing on build directory..."
#+++++++++++++++++++
# unzip -q /home/centos/rpm/$SRCDIR/bluecardinal.zip  -d /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/ 

#Removing created zip file
rm /home/centos/rpm/$SRCDIR/bluecardinal.tar
# rm /home/centos/rpm/$SRCDIR/bluecardinal-webclient.tar


echo "[+] Copying service files..."
# cp -r /home/centos/rpm/etc /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/etc %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

# echo "[+] Copying java files.."
# cp -r /home/centos/rpm/home/sigmastream/tmp /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/ > /dev/null
# echo "[+] Copying java files..."
# cp -r /home/centos/rpm/home/sigmastream/tmp /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/ > /dev/null

echo "[-] Removing other service files.."
# cd /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/etc/init.d/
cd %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/etc/init.d/
ls | grep -v bluecardinal | xargs rm
# cd /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/tmp
# rm jdk1.8.0_51.tgz
#---------------------------------------------End of installation section------------------------------------------

#-------------------------------------------Starting of file section-----------------------------------------------
%files
# /home/sigmastream/bluecardinal/bluecardinal-server/
/bluecardinal.tar
# /bluecardinal-webclient.tar
# /tmp/jdk1.8.0__51.tgz
/etc/init.d/bluecardinal
# /etc/init.d/bluecardinal-webclient

#-------------------------------------------End of file section----------------------------------------------------

#-------------------------------------------Starting of post section-----------------------------------------------

%post
#!/bin/bash/
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
echo " [ $GREEN OK $NORMAL ]"
echo -n "[+] Extracting system files..."
#+++++++++++++
# echo "[+] Starting Installation..."
sudo tar -xf bluecardinal.tar
# sudo tar -xf bluecardinal-webclient.tar
echo " [ $GREEN OK $NORMAL ]"
#---------------Symbolic link creation part started---------------
if [ ! -d "/home/sigmastream/bcserver" ]
    then
        echo -n "[+] Creating application symbolic link..."
        cd /home/sigmastream/
        ln -s /home/sigmastream/bluecardinal/bluecardinal-server/ bcserver
        # ln -s /home/sigmastream/bluecardinal/bluecardinal-server/ bcwebclient
        sudo chown -h sigmastream:sigmastream bcserver
        # sudo chown -h sigmastream:sigmastream bcwebclient
        echo " [ $GREEN OK $NORMAL ]"
    # else
        # echo "[-] Found BlueCardinal symbolic [  OK  ]"
fi

if [ ! -d "/apps/" ]
    then
        cd //
        ln -s /home/sigmastream/ apps
        sudo chown sigmastream:sigmastream /apps
    # else
        # echo "[-] Found home directory symbolic [  OK  ]"
fi
#---------------Symbolic link creation part Finished---------------

#------------CHECK AND INSTALL JAVA IF NOT INSTALLED---------------

# if [ ! -d "/home/sigmastream/bcserver/jre" ]	
#     then	
#         cd /home/sigmastream/bcserver/	
#         tar -xf /tmp/jdk1.8.0__51.tgz	
#         mv jdk1.8.0_51 jre	
#         echo "Copied java files [  OK  ]"	
#     else	
#         echo "[-] Found java files [  OK  ]"	
# fi

# cd /home/sigmastream/bcserver
# tar -xf /tmp/jdk1.8.0_51.tgz
# mv jdk1.8.0_51 jre

#-----------------Starting services part--------------------------
# echo "[+] Starting BlueCardinal as a service..."
sudo systemctl daemon-reload
sudo chmod +x /etc/init.d/bluecardinal
# sudo chmod +x /etc/init.d/bluecardinal-webclient
sudo systemctl enable bluecardinal > /dev/null 2>&1
# sudo systemctl enable bluecardinal-webclient > /dev/null 2>&1
# echo "[+] Getting status of BlueCardinal..."
# sudo service bluecardinal status

rm /bluecardinal.tar
# rm /bluecardinal-webclient.tar

sleep 2
sudo chown -R sigmastream:sigmastream /home/sigmastream/bcserver/
sudo chown -R sigmastream:sigmastream /home/sigmastream/bluecardinal/
# sudo chown sigmastream:sigmastream /home/sigmastream/bcwebclient/
# sudo chown -R sigmastream:sigmastream /home/sigmastream/bluecardinal/
sudo chmod -R 755 /home/sigmastream/bluecardinal/
sudo chown sigmastream:sigmastream /etc/init.d/bluecardinal
# sudo chown sigmastream:sigmastream /etc/init.d/bluecardinal-webclient

# echo "[+] Installing BlueCardinal-Server - Done"
echo ""
    echo "###"
    echo "[#] Application name: BlueCardinal-Server-1.2.0"
    echo "[#] Application installation path: /home/sigmastream/bluecardinal/bcserver-1.2.0/"
    echo "[#] Application log path: /home/sigmastream/bluecardinal/bcserver-1.2.0/logs/"
    echo "[#] Application service name: bluecardinal"
    # echo "[#] Application service name: bluecardinal-webclient"
    echo "[#] Command(s) to manage application: sudo service bluecardinal [start|stop|status|generate-keycode|apply-licensekey]"
    # echo "[#] Command(s) to manage application: sudo service bluecardinal-webclient [start|stop|status]"
    echo "###"
echo ""
# echo "[+] Generating public key for sigmastream stack..."
# echo "-------------------------------------------------------------------------------------"
sudo service bluecardinal generate-keycode
# echo "-------------------------------------------------------------------------------------"

#------------------------------------------------End oF post section------------------------------------------

#-------------------------------------------Start of uninstallation section-----------------------------------
%preun
echo "[+] Checking for running services..."
sudo service bluecardinal status > /dev/null 2>&1
if [ $? -eq 0 ]
    then 
        echo "[+] Stopping BlueCardinal services..."
        sudo service bluecardinal stop
        # sudo service bluecardinal-webclient stop
else    
    echo "[-] BlueCardinal service is already stopped."
    # sudo service bluecardinal-webclient stop > dev/null 2>&1
fi
#-------------------------------------------End of uninstallation section-----------------------------------
%changelog
# *Tried to touch one file.
# let's skip this for now