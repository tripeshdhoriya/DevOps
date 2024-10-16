Name:       HummingBird-Server
Version:    2
Release:    2
Summary:    HummingBird-Server
License:    SigmaStream LLC
Requires:   postgresql >= 9.0
Requires:   cassandra >= 3.0
Requires:   expect >= 4.0
Requires:   telnet >= 0.1
Requires:   iptables >= 1.0
Requires:   iptables-services >= 1.4
#Requires:   postgresql >= 9.6, cassandra >=3.10, expect >= 5

%description
HummingBird-Visualizer

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
SRCDIR=home/sigmastream/hummingbird
FOLDER_NAME=hummingbird-2.5/

# zip -rq $SRCDIR/hummingbird.zip $SRCDIR/$FOLDER_NAME
tar -zcf $SRCDIR/hummingbird.tar $SRCDIR/$FOLDER_NAME
tar -zcf $SRCDIR/ssh.tar home/sigmastream/.ssh/
# cp  $SRCDIR/hummingbird.tar /root/rpmbuild/BUILDROOT/HummingBird-Server-2-2.x86_64/ 
cp  $SRCDIR/hummingbird.tar %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch} 
cp  $SRCDIR/ssh.tar %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}
echo "[+] De-Compressing on build directory..."
#+++++++++++++++++++
# unzip -q /home/centos/rpm/$SRCDIR/hummingbird.zip  -d /root/rpmbuild/BUILDROOT/HummingBird-Server-2-2.x86_64/ 

#Removing created zip file
rm /home/centos/rpm/$SRCDIR/hummingbird.tar
rm /home/centos/rpm/$SRCDIR/ssh.tar

echo "[+] Copying service files..."
# cp -r /home/centos/rpm/etc /root/rpmbuild/BUILDROOT/HummingBird-Server-2-2.x86_64/ > /dev/null
cp -r /home/centos/rpm/etc %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null


echo "[-] Removing other service files.."
# cd /root/rpmbuild/BUILDROOT/HummingBird-Server-2-2.x86_64/etc/init.d/
cd %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/etc/init.d/
ls | grep -v hummingbird | xargs rm
# cd /root/rpmbuild/BUILDROOT/HummingBird-Server-2-2.x86_64/tmp
# rm jdk1.8.0_51.tgz
#---------------------------------------------End of installation section------------------------------------------

#-------------------------------------------Starting of file section-----------------------------------------------
%files
# /home/sigmastream/hummingbird/hummingbird-2.5/
/hummingbird.tar
/ssh.tar
# /tmp/jdk1.8.0__51.tgz
/etc/init.d/hummingbird

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
sudo tar -xf hummingbird.tar
sudo tar -xf ssh.tar
echo " [ $GREEN OK $NORMAL ]"
#---------------Symbolic link creation part started---------------
if [ ! -d "/home/sigmastream/hbserver" ]
    then
        echo -n "[+] Creating application symbolic link..."
        cd /home/sigmastream/
        ln -s /home/sigmastream/hummingbird/hummingbird-2.5/server/ hbserver
        sudo chown -h sigmastream:sigmastream hbserver
        echo " [ $GREEN OK $NORMAL ]"
    # else
        # echo "[-] Found HummingBird symbolic [  OK  ]"
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

#------------CHECK AND RESTORE DUMP IF NOT RESTORED---------------
TOOLSDIR=/home/sigmastream/hummingbird/hummingbird-2.5/Tools
PSQLDMPDIR=$TOOLSDIR/db_dump/postgres/
CQLDMPDIR=$TOOLSDIR/db_dump/cassandra/
SCRIPTDIR=$TOOLSDIR/scripts/

echo "" 
echo "[#] Starting HummingBird setup..."
echo ""
echo "[+] Starting dump restoration process..."
echo ""
echo "[+] Restoring postgres dump..."

#checking postgres db exists or not.
if [ "$( PGPASSWORD=postgres psql -U postgres -h localhost -tAc "SELECT 1 FROM pg_database WHERE datname='KFSeed'" )" = '1' ]
then
    echo "[#] Postgres database already exists."
else
    cd $PSQLDMPDIR
    echo ""
    sudo sh $PSQLDMPDIR/setup-postgres.sh | tee $PSQLDMPDIR/postgres-restore.log
fi

wait

# checking for existing cassandra keyspace
cqlsh -e "describe keyspaces;" | grep hummingbird_kf > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "[#] Cassandra keyspace is already exists."
else
    cd $CQLDMPDIR
    echo "[+] Restoring cassandra schema..."
    sudo sh $CQLDMPDIR/setup-cassandra.sh | tee $CQLDMPDIR/cassandra-restore.log
fi
#-----------------DUMP RESTORATION PART FINISHED-------------------

#-----------------Starting services part--------------------------
# echo "[+] Starting hummingbird as a service..."
sudo systemctl daemon-reload
sudo chmod +x /etc/init.d/hummingbird
sudo systemctl enable hummingbird > /dev/null 2>&1
# echo "[+] Getting status of hummingbird..."
# sudo service hummingbird status

sudo rm /hummingbird.tar
sudo rm /ssh.tar

sudo chmod 0700 /home/sigmastream/.ssh/
sudo chmod 0644 /home/sigmastream/.ssh/id_rsa.pub
sudo chmod 0600 /home/sigmastream/.ssh/id_rsa
sudo chmod 0600 /home/sigmastream/.ssh/authorized_keys
sudo chown sigmastream:sigmastream /home/sigmastream/.ssh/


sleep 2
sudo chown sigmastream:sigmastream /home/sigmastream/hbserver/
sudo chown -R sigmastream:sigmastream /home/sigmastream/hummingbird/
sudo chmod -R 755 /home/sigmastream/hbserver/
sudo chown sigmastream:sigmastream /etc/init.d/hummingbird

# LIST IP TABLES NAT RULES: sudo iptables -L -t nat -v
# FLUSH IP TABLES NAT RULES: sudo iptables -F -t nat -v
osver=$(cat /etc/os-* | grep "VERSION_ID" | grep -v grep |cut -d '=' -f 2 | cut -d '"' -f 2)
echo "[+] Setting up iptables to configure firewall redirect rules [8080 -> 80] & [8443 -> 443]"
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -t nat -I PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 8443
sudo service iptables save > /dev/null 2>&1
sudo systemctl enable iptables > /dev/null 2>&1

# echo ""
sudo service hummingbird generatekeycode
# echo ""

ip=$(ifconfig | grep inet | head -n 1 | awk '{print $2}' | cut -d ':' -f 2)

echo "-------------------------------------------------------------------------------------"
echo "[#] Application name: HummingBird"
echo "[#] Application installation path: /home/sigmastream/hummingbird/hummingbird-2.5/server/"
echo "[#] Application log path: /home/sigmastream/hummingbird/hummingbird-2.5/log/"
echo "[#] Application service name: hummingbird"
echo "[#] Command(s) to manage application: sudo service hummingbird [start|stop|status|generatekeycode|applylicensetoken|serverupdate]"
echo "-------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "[#] After applying the licensekey HummingBird server will be accessible at http[s]://$ip"
echo "-------------------------------------------------------------------------------------------"


#------------------------------------------------End oF post section------------------------------------------

#-------------------------------------------Start of uninstallation section-----------------------------------
%preun
echo "[+] Checking for running services..."
sudo service hummingbird status > /dev/null 2>&1
if [ $? -eq 0 ]
    then 
        echo "[+] Stopping HummingBird service..."
        sudo service hummingbird stop
else    
    echo "[-] HummingBird service is already stopped."
fi
#-------------------------------------------End of uninstallation section-----------------------------------
%changelog
# *Tried to touch one file.
# let's skip this for now