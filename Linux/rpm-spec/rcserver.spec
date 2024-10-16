Name:       RedCanary-Server
Version:    2
Release:    2
Summary:    RedCanary-Server
License:    SigmaStream LLC

%description
RedCanary-Server Package

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
SRCDIR=home/sigmastream/redcanary
FOLDER_NAME=rc-server/

zip -rq $SRCDIR/rcserver.zip $SRCDIR/$FOLDER_NAME

echo "[+] De-Compressing on build directory..."
# unzip -q /home/centos/rpm/$SRCDIR/rcserver.zip  -d /root/rpmbuild/BUILDROOT/RedCanary-Server-2-2.x86_64/ 
unzip -q /home/centos/rpm/$SRCDIR/rcserver.zip  -d %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}

#Removing created zip file
rm /home/centos/rpm/$SRCDIR/rcserver.zip

echo "[+] Copying service files..."
# cp -r /home/centos/rpm/etc /root/rpmbuild/BUILDROOT/RedCanary-Server-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/etc %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

echo "[+] Copying java files..."
# cp -r /home/centos/rpm/home/sigmastream/tmp /root/rpmbuild/BUILDROOT/RedCanary-Server-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/home/sigmastream/tmp %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

# echo "[+] Copying java files..."
# cp -r /home/centos/rpm/home/sigmastream/tmp /root/rpmbuild/BUILDROOT/BlueCardinal-Server-2-2.x86_64/ > /dev/null
# cd /root/rpmbuild/BUILDROOT/RedCanary-Server-2-2.x86_64/etc/init.d/
cd %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/etc/init.d/
ls | grep -v rcserver | xargs rm
cd -
#---------------------------------------------End of installation section------------------------------------------

#-------------------------------------------Starting of file section-----------------------------------------------

%files
/home/sigmastream/redcanary/rc-server/

/etc/init.d/rcserver
/tmp/jdk1.8.0_51.tgz
#-------------------------------------------End of file section----------------------------------------------------

#-------------------------------------------Starting of post section-----------------------------------------------
%post
#!/bin/bash/
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
echo " [ $GREEN OK $NORMAL ]"
#------------------------Symbolic link creation part Started------------------------
# echo "[+] Preparing files..."
if [ ! -d "/home/sigmastream/rcserver" ]
    then
        echo -n "[+] Creating application symbolic link..."
        cd /home/sigmastream/
        ln -s /home/sigmastream/redcanary/rc-server/ rcserver
        sudo chown -h sigmastream:sigmastream rcserver
        echo " [ $GREEN OK $NORMAL ]"
    # else
        # echo "[-] Found rcserver symbolic link [  OK  ]"
fi

if [ ! -d "/apps/" ]
    then
        cd //
        ln -s /home/sigmastream/ apps
        sudo chown -h sigmastream:sigmastream /apps
    # else/
        # echo "[-] Found home symbolic [  OK  ]"
fi
#-----------------------Symbolic link creation part Finished----------------------
if [ ! -d "/home/sigmastream/rcserver/java" ]
    then
        echo -n "[+] Setting up Java 1.8 runtime..."
        cd /home/sigmastream/rcserver/
        tar -xf /tmp/jdk1.8.0_51.tgz
        mv jdk1.8.0_51 java
        rm /tmp/jdk1.8.0_51.tgz > /dev/null 2>&1
        echo " [ $GREEN OK $NORMAL ]"
    else
        echo "[+] Java 1.8 is already setup [ $GREEN OK $NORMAL ]"
fi
#-------------------------------Extracting Jar files------------------------
# echo "[+] Extracting system files"
# cd /home/sigmastream/

#-----------------------------Starting services part------------------------
sudo systemctl daemon-reload
sudo systemctl enable rcserver > /dev/null 2>&1
sudo chmod +x /etc/init.d/rcserver
# echo "[+] Installing RedCanary-Server - Done"

# echo "[+] Starting RedCanary-Server as a service..."
# sudo service rcserver start > /dev/null 2>&1
sleep 2
echo ""
echo "###"
echo "[#] Application name: RedCanary-Server-2.0.0"
echo "[#] Application installation path: /home/sigmastream/redcanary/rc-server/"
echo "[#] Application log path: /home/sigmastream/redcanary/rc-server./logs/"
echo "[#] Application service name: rcserver"
echo "[#] Command(s) to manage application: sudo service rcserver [start|stop|status]"
echo "###"
echo ""
# echo "[+] Getting status of RedCanary-Server..."
# echo "[+] `exec sudo service rcserver status`"
ip=$(ifconfig | grep inet | awk '{print $2}' | head  -n 1)
sudo chown sigmastream:sigmastream /home/sigmastream/rcserver/
sudo chown -R sigmastream:sigmastream /home/sigmastream/redcanary/
sudo chmod -R 755 /home/sigmastream/redcanary/
sudo chown sigmastream:sigmastream /etc/init.d/rcserver
echo ""
# echo "[+] Generating public key for sigmastream stack..."
# sudo service bluecardinal generate-license-key
echo "-----------------------------------------------------------------------------------------"
echo "[#] After starting service, you can access application at https://$ip:8444"
echo "-----------------------------------------------------------------------------------------"
#------------------------------------------------End oF post section------------------------------------------

#-------------------------------------------Start of uninstallation section-----------------------------------
%preun
echo "[+] Checking for running services..."
sudo service rcserver status > /dev/null 2>&1
if [ $? -eq 0 ]
    then 
        echo "[+] Stopping RedCanary-Server service..."
        sudo service rcserver stop
else    
    echo "[-] RedCanary-Server service is already stopped."
fi
#-------------------------------------------End of uninstallation section-------------------------------------
%changelog
# *Tried to touch one file.
# let's skip this for now