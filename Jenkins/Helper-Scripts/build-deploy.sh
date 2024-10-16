#!/bin/bash

# Running Build collection script 
source ./yh-build-collection.sh
sleep 5
#MAKING SURE YELLOWHAMMER SERVER IS STOPPED
echo "[-]Stopping YellowHammer-Server"
# sudo service yhsource stop
# sleep 2
printf "[+] YellowHammer-Server is Stopped"
printf "\n"
printf "[+] Upgrading WAR file"
printf "\n"
# cd /apps/yhsource/yellowhammer/yellowhammer-base/webapps/ROOT/
# rm *
# rm -r WEB-INF/ META-INF/ java/ dist/ api-definitions/
# cd ..
# mv ROOT.war ROOT-war
# cp ${BUILDDIR}/yellowhammer-server/ROOT.war .
# touch ROOT.war
# cd ..

#Updating config-ext.properties
printf "[+] Checking and Upgrading Config-ext properties"
configupdate=$BUILDDIR/yellowhammer-server/ext_upgrade.properties
actualconfigext=/apps/yhsource/yellowhammer/yellowhammer-base/config-ext.properties
# grep -qxF 'include' $configupdate config-ext.properties || echo 'include "${BUILDDIR}/yellowhammer-server/ext_upgrade.properties"' >> config-ext.properties
s=$BUILDDIR/yellowhammer-server/ext_upgrade.properties; grep -Fxqe "$s" < "$actualconfigext" || printf "%s\n" "$s" >> "$actualconfigext"
printf "\n [-]Running TAC to remove excess lines from config-ext file"
# sed '1d' $actualconfigext
# sed '1d' $actualconfigext
tac $actualconfigext | sed "1,2d" | tac
# tac $actualconfigext | sed "1,1d" | tac
printf "\n"

#Starting YellowHammer server service
# sudo service yhsource start
# sleep 10
# printf "[+] YellowHammer-Server is up and running"

# #Upgrading YellowHammer-WebClient
# printf "[-] Stopping YellowHammer-Webclient"
# sudo service yhwebclient stop
# sleep 2
# cd /apps/yhsource/yellowhammer-webclient/
# mv yh-webclient.jar yh-webclient-jar
# mv webapp/ webapp-old/
# cp ${BUILDDIR}/yellowhammer-webclient/webapp.zip .
# cp ${BUILDDIR}/yellowhammer-webclient/yh-webclient-jar-with-dependencies.jar ./yh-webclient.jar
# mv webapp-old/ yh-webclient-jar old_build/

# printf "[+] Starting YellowHammer-Webclient"
# sudo serice yhwebclient start