Name:       RockPigeon-Server
Version:    1
Release:    1
Summary:    RockPigeon-Server
License:    SigmaStream LLC
Requires:   postgresql >= 9.0
Requires:   expect >= 4.0
Requires:   telnet >= 0.1
Requires:   iptables >= 1.4
Requires:   iptables-services >= 1.4
#Requires:   postgresql >= 9.6, cassandra >=3.10, expect >= 5

%description
RockPigeon-Server

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
    echo "$USERNAME:SigmaStream#1" | chpasswd
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
SRCDIR=home/sigmastream/rockpigeon
FOLDER_NAME=rockpigeon-server/

# zip -rq $SRCDIR/rockpigeon.zip $SRCDIR/$FOLDER_NAME
tar -zcf $SRCDIR/rockpigeon.tar $SRCDIR/$FOLDER_NAME
tar -zcf $SRCDIR/ssh.tar home/sigmastream/.ssh/
cp  $SRCDIR/rockpigeon.tar %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}
cp  $SRCDIR/ssh.tar %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}
echo "[+] De-Compressing on build directory..."
#+++++++++++++++++++

#Removing created zip file
rm /home/centos/rpm/$SRCDIR/rockpigeon.tar
rm /home/centos/rpm/$SRCDIR/ssh.tar

echo "[+] Copying service files..."
cp -r /home/centos/rpm/etc %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/ > /dev/null

echo "[-] Removing other service files.."

cd %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}/etc/init.d/
ls | grep -v rockpigeon | xargs rm

#---------------------------------------------End of installation section------------------------------------------

#-------------------------------------------Starting of file section-----------------------------------------------
%files
# /home/sigmastream/rockpigeon/rockpigeon-server/
/rockpigeon.tar
/ssh.tar
# /tmp/jdk1.8.0__51.tgz
/etc/init.d/rockpigeon

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
sudo tar -xf rockpigeon.tar
sudo tar -xf ssh.tar
echo " [ $GREEN OK $NORMAL ]"
#---------------Symbolic link creation part started---------------
if [ ! -d "/home/sigmastream/rpserver" ]
    then
        echo -n "[+] Creating application symbolic link..."
        cd /home/sigmastream/
        ln -s /home/sigmastream/rockpigeon/rockpigeon-server/server/ rpserver
        sudo chown -h sigmastream:sigmastream rpserver
        echo " [ $GREEN OK $NORMAL ]"
    # else
        # echo "[-] Found RockPigeon symbolic [  OK  ]"
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
TOOLSDIR=/home/sigmastream/rockpigeon/rockpigeon-server/tools
PSQLDMPDIR=$TOOLSDIR/db_dump/postgres/
CQLDMPDIR=$TOOLSDIR/db_dump/cassandra/
SCRIPTDIR=$TOOLSDIR/scripts/

echo "[+] Restoring postgres dump..."

#checking postgres db exists or not.
if [ "$( PGPASSWORD=postgres psql -U postgres -h localhost -tAc "SELECT 1 FROM pg_database WHERE datname='kingfisher'" )" = '1' ]
then
    echo "[#] Postgres database already exists."
    cd $PSQLDMPDIR/view/ || exit 3
    echo -n "[+] Running migration scripts, It may take while.."
    sudo sh $PSQLDMPDIR/view/syncApplied.sh > $PSQLDMPDIR/postgres-migration.log 2>&1
    echo " [ $GREEN OK $NORMAL ]"
    # echo ""
    # echo -n "[+] Creating views..."
    # cd $PSQLDMPDIR/view/
    # sudo sh $PSQLDMPDIR/view/install-views.sh > $PSQLDMPDIR/postgres-views.log
    # echo " [ $GREEN OK $NORMAL ]"
    # cd - > /dev/null 2>&1
else
    cd $PSQLDMPDIR
    echo "[+] Restoring database, It may take while..."
    sudo sh $PSQLDMPDIR/setup-postgres.sh | tee $PSQLDMPDIR/postgres-restore.log 2>&1
    cd $PSQLDMPDIR/view/ || exit 3
    echo -n "[+] Running migration scripts, It may take while.."
    sudo sh $PSQLDMPDIR/view/syncApplied.sh > $PSQLDMPDIR/postgres-migration.log 2>&1
    echo " [ $GREEN OK $NORMAL ]"
    cd - > /dev/null 2>&1
    # echo ""
    # echo -n "[+] Creating views..."
    # cd $PSQLDMPDIR/view/
    # sudo sh $PSQLDMPDIR/view/install-views.sh > $PSQLDMPDIR/postgres-views.log
    # echo " [ $GREEN OK $NORMAL ]"
    # cd - > /dev/null 2>&1
fi

wait

#-----------------DUMP RESTORATION PART FINISHED-------------------

#-----------------Starting services part--------------------------
# echo "[+] Starting RockPigeon as a service..."
sudo systemctl daemon-reload
sudo chmod +x /etc/init.d/rockpigeon
sudo systemctl enable rockpigeon > /dev/null 2>&1
# echo "[+] Getting status of RockPigeon..."
# sudo service rockpigeon status

sudo rm /rockpigeon.tar
sudo rm /ssh.tar

sudo chmod 0700 /home/sigmastream/.ssh/
sudo chmod 0644 /home/sigmastream/.ssh/id_rsa.pub
sudo chmod 0600 /home/sigmastream/.ssh/id_rsa
sudo chmod 0600 /home/sigmastream/.ssh/authorized_keys
sudo chown sigmastream:sigmastream /home/sigmastream/.ssh/
sleep 2
sudo chown sigmastream:sigmastream /home/sigmastream/rpserver/
sudo chown -R sigmastream:sigmastream /home/sigmastream/rockpigeon/
sudo chmod -R 755 /home/sigmastream/rpserver/
sudo chown sigmastream:sigmastream /etc/init.d/rockpigeon

# LIST IP TABLES NAT RULES: sudo iptables -L -t nat -v
# FLUSH IP TABLES NAT RULES: sudo iptables -F -t nat -v
# osver=$(cat /etc/os-* | grep "VERSION_ID" | grep -v grep |cut -d '=' -f 2 | cut -d '"' -f 2)
echo -n "[+] Setting up iptables redirect rules [9090 -> 80] & [9443 -> 443]..."
sudo systemctl mask firewalld > /dev/null 2>&1
sudo systemctl stop firewalld > /dev/null 2>&1
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 9090
sudo iptables -t nat -I PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 9443
sudo service iptables save > /dev/null 2>&1
sudo systemctl enable iptables > /dev/null 2>&1
echo " [ $GREEN OK $NORMAL ]"


# echo ""
sudo service rockpigeon generatekeycode
# echo ""

ip=$(ifconfig | grep inet | head -n 1 | awk '{print $2}' | cut -d ':' -f 2)

echo "-------------------------------------------------------------------------------------"
echo "[#] Application name: RockPigeon"
echo "[#] Application installation path: /home/sigmastream/rockpigeon/rockpigeon-server/server/"
echo "[#] Application log path: /home/sigmastream/rockpigeon-server/server/log/"
echo "[#] Application service name: rockpigeon"
echo "[#] Command(s) to manage application: sudo service rockpigeon [start|stop|status|generatekeycode|applylicensetoken|serversetup]"
echo "-------------------------------------------------------------------------------------"
echo "-------------------------------------------------------------------------------------------"
echo "[#] After applying the licensekey RockPigeon server will be accessible at http[s]://$ip"
echo "-------------------------------------------------------------------------------------------"


#------------------------------------------------End oF post section------------------------------------------

#-------------------------------------------Start of uninstallation section-----------------------------------
%preun
echo "[+] Checking for running services..."
sudo service rockpigeon status > /dev/null 2>&1
if [ $? -eq 0 ]
    then 
        echo "[+] Stopping RockPigeon service..."
        sudo service rockpigeon stop
else    
    echo "[-] RockPigeon service is already stopped."
fi
#-------------------------------------------End of uninstallation section-----------------------------------
%changelog
# *Tried to touch one file.
# let's skip this for now