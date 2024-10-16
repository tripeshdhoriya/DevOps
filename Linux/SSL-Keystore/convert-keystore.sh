#!/bin/sh

#Script to auto renew certificate and create keystore, PKCS12 file out of it.
# Only uncomment the service restart lines if you are 100% sure to restart the application everytime the certs get renewed.

set -e
service_name=yhserver
app_kestore_path="/apps/yhserver/yellowhammer-base/etc"
keystore_name="yellowhammer.keystore"
time=$(date +%d%m%y_%H%M%S)
pkpass="SigmaStream#1"
storepass=${pkpass}
domain=yellowhammer-chevron.sigmastream.com
letsencryptpath=/etc/letsencrypt/live/${domain}/
openssl version > /dev/null
openssl_status=$?
keytool > /dev/null
keytool_status=$?

generatekeystore() {
    cd ${letsencryptpath} || { echo "[!] unable to cd ${letsencryptpath}, EXITING"; exit 1; }
    
    echo "[#] Generating key store"
    openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -certfile cert.pem -name ${domain} -out jetty.pkcs12 -passout "pass:$pkpass"
    
    sudo mv ${app_kestore_path}/${keystore_name} ${app_kestore_path}/${keystore_name}_${time}
    
    echo "[#] Applying key store"
    keytool -importkeystore -noprompt -srckeystore jetty.pkcs12 -srcstoretype PKCS12 -srcstorepass "$pkpass" -destkeystore ${app_kestore_path}/${keystore_name} -deststorepass "$storepass"
    
}

if [ "$keytool_status" = 0 ] && [ "$openssl_status" = 0 ]; then
    echo "[#] Verified openssl & keytool"
    if [ -d ${letsencryptpath} ]; then
        #cert renew command
        echo "[!] Certificate already exists! Do you want to renew it?"
        #read -p "Yes(y) or No(n)?" -n 1 -r
        echo
	    REPLY=y
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [ $? -eq 0 ]; then
                #sudo service ${service_name} stop
                #sudo certbot -n certonly --standalone --agree-tos --preferred-challenges http -d $domain #Generate keystore for first time.
                sudo certbot renew --standalone --agree-tos --preferred-challenges http --force-renewal #For force renewal, use this line when configuring this script into cron job.
		if [ $? -eq 0 ]; then
	                generatekeystore
		fi
            else
                echo "[!] Fail to create SSL, please check letsencrypt logs."
            fi
        else
            echo "[#] Exiting.!"
            exit 1
        fi
    else
        #echo "[#] Stopping service ${service_name}"
	    echo ""
        #sudo service ${service_name} stop
        if [ $? -eq 0 ]; then
            generatekeystore
        else
            echo "[!] Fail to create SSL, please check letsencrypt logs."
        fi
    fi
    #echo "[#] Starting service $service_name"
    #sudo service ${service_name} restart
    
else
    echo "[!] Openssl or keytool isn't installed."
fi