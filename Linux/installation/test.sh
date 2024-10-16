#!/bin/bash

osver=$(cat /etc/os-* | grep "VERSION_ID" | grep -v grep |cut -d '=' -f 2 | cut -d '"' -f 2)

if [ ${osver} -eq "7" ]; then
    echo "setup rules for centOS7"
elif [ ${osver} -eq "8" ]; then  
    echo "setup rules for centos8"
else
    echo 'unable to setup redirect rules for this installation.'
fi