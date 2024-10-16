Name:       YellowHammer-Server
Version:    2
Release:    2
Summary:    YellowHammer-Server
License:    SigmaStream LLC

%description
YellowHammer-Server Package

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
echo -n "[+] Installing application... "
#----------------------ADD USER SECTION FINISHED-----------------
%build
#Nothing here
#-------------------------------------------Starting of installation section------------------------------------------
%install

echo "[+] Compressing files for build..."
cd /home/centos/rpm/
#yellowhammer-server - directory name
SRCDIR=home/sigmastream/yellowhammer

zip -rq $SRCDIR/yhserver.zip $SRCDIR/yellowhammer/ $SRCDIR/yellowhammer-server/

echo "[+] De-Compressing on build directory..."
# unzip -q /home/centos/rpm/$SRCDIR/yhserver.zip  -d /root/rpmbuild/BUILDROOT/YellowHammer-Server-2-2.x86_64/ 
unzip -q /home/centos/rpm/$SRCDIR/yhserver.zip  -d %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch} 

#Removing created zip file
rm /home/centos/rpm/$SRCDIR/yhserver.zip

echo "[+] Copying service files..."
# cp -r /home/centos/rpm/etc /root/rpmbuild/BUILDROOT/YellowHammer-Server-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/etc %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

echo "[+] Copying java files..."
# cp -r /home/centos/rpm/home/sigmastream/tmp /root/rpmbuild/BUILDROOT/YellowHammer-Server-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/home/sigmastream/tmp %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

# rm /root/rpmbuild/BUILDROOT/YellowHammer-Server-2-2.x86_64/etc/init.d/yhwebclient
# cd /root/rpmbuild/BUILDROOT/YellowHammer-Server-2-2.x86_64/etc/init.d/
cd %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/etc/init.d/
ls | grep -v yhserver | xargs rm
cd -
#---------------------------------------------End of installation section------------------------------------------

#-------------------------------------------Starting of file section-----------------------------------------------
%files
# echo "[+] Copying source  files..."
/home/sigmastream/yellowhammer/yellowhammer-server/
# echo "[+] Copying java files..."
/tmp/jdk1.8.0_51.tgz
#/tmp/install-mongo.sh
# echo "[+] Copying service files..."
/etc/init.d/yhserver

#-------------------------------------------End of file section----------------------------------------------------

#-------------------------------------------Starting of post section-----------------------------------------------
%post
#!/bin/bash/
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)
echo " [ $GREEN OK $NORMAL ]"
# echo "[+] Starting Installation..."
#------------------------Symbolic link creation part Started------------------------
if [ ! -d "/home/sigmastream/yhserver" ]
    then
        echo -n "[+] Creating application symbolic link..."
        cd /home/sigmastream/
        ln -s /home/sigmastream/yellowhammer/yellowhammer-server/ yhserver
        sudo chown -h sigmastream:sigmastream yhserver
        echo " [ $GREEN OK $NORMAL ]"
    # else
        # echo "[-] Found yhserver symbolic [  OK  ]"
fi

if [ ! -d "/apps/" ]
    then
        cd //
        ln -s /home/sigmastream/ apps
        sudo chown -h sigmastream:sigmastream /apps
    # else
        # echo "[-] Found home symbolic"
fi

# echo "[+] Preparing Files..."
#-----------------------Symbolic link creation part Finished----------------------

#----------------------File Extraction & Service start part-----------------------
# echo "[+] Extracting system files..."
if [ ! -d "/apps/yhserver/java" ]
    then
        echo -n "[+] Setting up Java 1.8 runtime..."
        cd /apps/yhserver/
        tar -xf /tmp/jdk1.8.0_51.tgz
        mv jdk1.8.0_51 java
        rm /tmp/jdk1.8.0_51.tgz > /dev/null 2>&1
        echo " [ $GREEN OK $NORMAL ]"
    else
        echo "[+] Java 1.8 is already setup [ $GREEN OK $NORMAL ]"
fi
# echo "[+] Extracting System File - Done"

touch /home/sigmastream/yhserver/yellowhammer-base/webapps/ROOT.war
#-------------------------------------Jar file Part Finished------------------------------------------------

#-------------------------------------MongoDB Installation Part---------------------------------------------
#echo "[+] Checking MongoDB is installed or not.."
#mongo --version > /dev/null
#if [ $? -ge 1 ]
#then
#echo "[+] MongoDB is not installed, Preparing for installation.."
#sudo chmod +x /tmp/install-mongo.sh
#sudo sh /tmp/install-mongo.sh
#-------------------------------------MongoDB Installation Finished------------------------------------------

#-------------------------------------------Starting services part-------------------------------------------
# echo "[+] Starting YellowHammer-Server as a service..."
sudo systemctl daemon-reload
sudo chmod +x /etc/init.d/yhserver
sudo systemctl enable yhserver > /dev/null 2>&1

# sudo service yhserver start > /dev/null 2>&1

# echo "[+] Installing YellowHammer-Server - Done"
echo ""
echo "###"
echo "[#] Application name: YellowHammer-Server"
echo "[#] Application installation path: /home/sigmastream/yellowhammer/yellowhammer-server/"
echo "[#] Application log path: /home/sigmastream/yellowhammer/yellowhammer-server/yellowhammer-base/logs/"
echo "[#] Application service name: yhserver"
echo "[#] Command(s) to manage application: sudo service yhserver [start|stop|status|generate-keycode|apply-licensekey]"
echo "###"
echo ""
# echo "[+] Getting status of YellowHammer-Server..."
# sudo service yhserver status | grep -e YellowHammer-Server --colour=never
sudo chown sigmastream:sigmastream /home/sigmastream/yhserver/
sudo chown -R sigmastream:sigmastream /home/sigmastream/yellowhammer/
sudo chmod -R 755 /home/sigmastream/yellowhammer/
sudo chown sigmastream:sigmastream /etc/init.d/yhserver
ip=$(ifconfig | grep inet | awk '{print $2}' | head  -n 1)

# echo "[+] Generating public key for sigmastream stack..."
# echo "-------------------------------------------------------------------------------------"
sudo service yhserver generatekeycode
# echo "-------------------------------------------------------------------------------------"

echo "-------------------------------------------------------------------------------------------"
echo "[#] After starting service, you can access application at https://$ip:8443"
echo "-------------------------------------------------------------------------------------------"

# TO-DO
#Add curl coomand and check yhserver is up or not if it's up then print server statted message.
# rm /jdk1.8.0_51.tgz
#------------------------------------------End oF post section-----------------------------------------------

#-------------------------------------------Start of uninstallation section-----------------------------------
%preun
# echo "[+] Checking for running services..."
echo "[+] Checking for running services..."
sudo service yhserver status > /dev/null 2>&1
if [ $? -eq 0 ]
    then 
        echo "[+] Stopping YellowHammer-Server service..."
        sudo service yhserver stop
else    
    echo "[-] YellowHammer-Server service is already stopped."
fi
#-------------------------------------------End of uninstallation section-------------------------------------
%changelog
# *Tried to touch one file.
# let's skip this for now