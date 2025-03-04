#!/bin/bash
# set -x #enable to run script in debug mode.
service_name=$1 #Valid service name.
process_name=$2 ##to grab the pid
fd_threshold=$3 #Integer
pcpu_threshold=$4 #% Integer
pmem_threshold=$5 #% Integer
sysload_threshold=$6 #% Integer
url=$7 ## https://127.0.0.1:8447
logpath=$8 ## /apps/yhwebclient/logs/yh_wc_monitor.log
alertstatus=$9
WEBHOOK_URL=https://sigmastreamcom.webhook.office.com/webhookb2/8c78ee27-09f8-47d9-a0ba-80cc98d76acb@9c6e8818-9573-4af1-a3f4-2d19bf10a063/IncomingWebhook/4f4369ee48974d199e31f78918f29850/d8146787-3eaa-4062-b82f-845f245f689f
THREAD_THRESHOLD=7300

Process_PID=$(/usr/bin/pgrep -f "$process_name" | head -1)
# echo "PID: $Process_PID"
secs=$(/usr/bin/ps -o etimes -p "${Process_PID}" | tail -1 | tr -d ' ')
UPTIME=$(/usr/bin/printf '%dh-%dm-%ds\n' $((secs/3600)) $((secs%3600/60)) $((secs%60)))
FD_LIMIT=$(/usr/bin/grep -i "max open files" "/proc/${Process_PID}/limits" | awk '{print $4}')

function sendalert {
    if [ $alertstatus == "TRUE" ]; then
        MESSAGE=$(echo $message | sed 's/"/\"/g' | sed "s/'/\'/g" )
        # IP=$(echo $ip)
        TITLE="`hostname`:- `echo $ip`"
        JSON="{\"title\": \"${TITLE}\", \"themeColor\": \"${COLOR}\", \"text\": \"${MESSAGE}\" }"
        curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK_URL}"
    else
        return 1
    fi
}

function getlastupdatedtime {
    TIMECHECK=$(date +%d/%m/%Y' '%H'h'-''%M'm'-''%S's')
}

function validateservice {
    sudo service "$service_name" status > /dev/null
    s_status=$?
    if [ $s_status -eq 0 ]; then
        s_status="SUCCESS:RUNNING"
    elif [ "$s_status" -ge 4 ]; then
        # echo "[!] service($service_name) not found, Exiting!" 
        echo "FAILED $(/bin/date):INVALID_SERVICE_NAME($service_name)" | tee -a "$logpath"
        message="FAILED $(/bin/date):INVALID_SERVICE_NAME($service_name)"
        sendalert $message
        exit 1
    else
        # echo "[!] service isn't running restarting service $service_name"
        echo "FAILED $(/bin/date):RESTARTING_SERVICE($service_name)" | tee -a "$logpath"
        message="FAILED $(/bin/date):RESTARTING_SERVICE($service_name)"
        sendalert $message
        # sudo service "${service_name}" restart
        exit 1
    fi
}

function checkcurl {
    curl_status=""
    if [ "${url}" ]; then
        /usr/bin/curl -sk "${url}" --connect-timeout 15 > /dev/null
        curl_status=$?
        if [ $curl_status -eq 0 ]; then
            # echo "[#] Service is accessible."
            curl_status="SUCCESS"
        else
            # echo "[!] Service($service_name) isn't accessible, restarting it."
            curl_status="FAILED"
            # sudo service "${service_name}" restart
            # exit 1
        fi
    else
        # echo "Missing url parameter"
        curl_status="FAILED:NaN"
    fi
}

function checkprocessmem {
    if [ "${Process_PID}" ]; then
        pmem_status=""
        pmem=$(ps -p "${Process_PID}" -o %mem | tail -1 | tr -d ' ')
        pmem=${pmem%.*}
        # echo "pmem: $pmem"
        if [ "$pmem" -gt "$pmem_threshold" ]; then
            # echo "FAIL:$service_name memory usage($pmem%) is higher than given threshold($pcpu_threshold%)."
            pmem_status="FAILED"
        else
            # echo "SUCCESS:$service_name memory usage($pmem%) is lower than given threshold($pcpu_threshold%)."
            pmem_status="SUCCESS"
        fi
    else
        pmem_status="FAILED:NaN"
    fi
}

function checkprocesscpu {
    # Process_PID=$(/usr/bin/pgrep -f "$process_name" | head -1)
    if [ -n "${Process_PID}" ]; then
        # SUBSTRING=$(sed 's#.*:##g' <<< "$INPUT")
        # loadAvg=$(echo "$SUBSTRING" | cut -d',' -f1)
        pcpu_status=""
        pcpu=$(/usr/bin/ps -p "${Process_PID}" -o %cpu | tail -1)
        pcpu=${pcpu%.*}
        pcpu=$(echo "${pcpu}" | tr -d ' ' )
        # echo "pcpu: $pcpu"
        if [ "$pcpu" -gt "$pcpu_threshold" ]; then
            # echo "FAIL:$service_name cpu usage($pcpu%) is higher than given threshold($pcpu_threshold%)."
            pcpu_status="FAILED"
        else
            # echo "SUCCESS:$service_name cpu usage($pcpu%) is lower than given threshold($pcpu_threshold%)." 
            pcpu_status="SUCCESS"
        fi
    else
        pcpu_status="FAILED:NaN"
        # exit 1
    fi
}

function checkprocessfd {
    process_fd_status=""
    PFD=$(sudo /usr/bin/ls /proc/"${Process_PID}"/fd | wc -l)
    # echo "PFD: $PFD"
    if [ -z "$PFD" ]; then
        # echo "[#] Unable to calculate Process file descriptor"
        process_fd_status="FAILED:NaN"
    else
        if [ "$PFD" -gt "$fd_threshold" ]; then
            # echo "FAIL:$service_name FD count($PFD) is greater than given threshold($fd_threshold)"
            process_fd_status="FAILED"
        else
            # echo "SUCCESS:$service_name FD count($PFD) is lower than given threshold($fd_threshold)"
            process_fd_status="SUCCESS"
        fi
    fi
}

function checksysload {
    sysload_status=""
    sysload=$(/usr/bin/top -n 1 -b | grep "load average:" | awk '{print $13}' | tr -d '',)
    sysload=${sysload%.*}
    if [[ "$sysload" > "$sysload_threshold" ]]; then 
        sysload_status="FAILED"
    else
        sysload_status="SUCCESS"
    fi
}

function checkportaccess {
    host=$(echo "$url" |  awk -F ":" '{print $2}')
    # port=$(echo "$url" |  awk -F ":" '{print $3}' | awk -F "/" '{print $1}')
    port=$(echo "$url" |  awk -F ":" '{print $3}')
    #fix me, warning code exection.
    # echo "$port"
    /usr/bin/timeout 3 bash -c "cat < /dev/null > /dev/tcp/$host/$port" 2> /dev/null
    if [ $? -eq 0 ]; then
        port_status="SUCCESS"
    else
        port_status="FAILED"
    fi
}

function checkthreads {
    OPEN_THREAD=$(/bin/ps -T -p ${Process_PID} | /bin/wc -l )
    if [ "${OPEN_THREAD}" -gt "${THREAD_THRESHOLD}" ]; then
        thread_status="FAILED"
    else
        thread_status="SUCCESS"
    fi

}

### Call functions to get the latest status ##
validateservice
checkcurl
checkprocessfd
checkprocesscpu
checkprocessmem
checksysload
checkportaccess
checkthreads
##--------------------------------------------------##

###DEBUG####
# echo "PID: $Process_PID"
# echo "Uptime: $UPTIME"
# echo "ProcessCPU: $pcpu , threshold: $pcpu_threshold, status: $pcpu_status"
# echo "ProcessMem: $pmem, threshold: $pmem_threshold, status: $pmem_status"
# echo "ProcessFD: $PFD, threshold: $fd_threshold, status: $process_fd_status"
# echo "SysLoad: $sysload, threshold: $sysload_threshold, status: $sysload_status"
# echo "Curl: $url, status: $curl_status"
# echo "Port: $port, status: $port_status"
####xxx#####

if [ $pmem_status == "FAILED:NaN" ] || [ $pcpu_status == "FAILED:NaN" ] || [ $process_fd_status == "FAILED:NaN" ]; then
    echo "FAILED:NaN:Mem=$pmem_status,CPU=$pcpu_status,FD=$process_fd_status"
    COLOR=ff0000
    message="FAILED: Memory error:NaN:Mem=$pmem_status,CPU=$pcpu_status,FD=$process_fd_status, Checked at: $TIMECHECK || Uptime: $UPTIME"
    sendalert $message
    exit 1
else 
    if [ $pcpu_status == "FAILED" ] && [ $pmem_status == "FAILED" ] && [ $sysload_status == "FAILED" ]; then
        echo "RESTARTED:$(/bin/date) || Uptime(m)=$UPTIME|| PCPU($pcpu),PMEM($pmem) and load_avg($sysload) are above threshold"  >> "$logpath"
        getlastupdatedtime
        echo "RESTARTED:PCPU($pcpu),PMEM($pmem) and load_avg($sysload) are above threshold:$TIMECHECK:$UPTIME"
        COLOR=ff9d5c
        message="WARNING: PCPU($pcpu),PMEM($pmem) and load_avg($sysload) are above threshold. Checked at: $TIMECHECK Uptime: $UPTIME"
        sendalert $message
        # sudo service "${service_name}" restart
        exit 1
    elif [ $pcpu_status == "FAILED" ] && [ "$sysload_status" == "FAILED" ]; then
        echo "RESTARTED:$(/bin/date) || Uptime(m)=$UPTIME|| PCPU($pcpu) and load_avg($sysload) are above threshold"  >> "$logpath"
        getlastupdatedtime
        echo "RESTARTED:PCPU($pcpu) and load_avg($sysload) are above threshold:$TIMECHECK:$UPTIME"
        COLOR=ff9d5c
        message="WARNING: PCPU($pcpu) and load_avg($sysload) are above threshold, Checked at: $TIMECHECK Uptime: $UPTIME"
        sendalert $message
        # sudo service "${service_name}" restart
        exit 1
    elif [ $curl_status == "FAILED" ] && [ $port_status == "FAILED" ]; then
        echo "RESTARTED:$(/bin/date) || Uptime(m)=$UPTIME|| Service & Port are not accessible ($url)." >> "$logpath"
        getlastupdatedtime
        echo "RESTARTED:Service & Port are not accessible ($url):$TIMECHECK:$UPTIME"
        sudo service "${service_name}" restart
        COLOR=ff0000
        message="WARNING: $(/bin/date) || Uptime(m)=$UPTIME|| Service & Port are not accessible ($url). Checked at: $TIMECHECK || Uptime: $UPTIME"
        sendalert $message
        exit 1
    elif [ $process_fd_status == "FAILED" ]; then
        echo "WARNING:$(/bin/date) || Uptime(m)=$UPTIME|| $process_name FD counts($PFD) are above threshold." >> "$logpath"
        getlastupdatedtime
        COLOR=FFA500
        echo "WARNING:$process_name FD counts($PFD) are above threshold($fd_threshold).:$TIMECHECK:$UPTIME"
        message="WARNING: $process_name FD counts($PFD) are above threshold($fd_threshold). || Checked at: $TIMECHECK || Uptime: $UPTIME"
        sendalert $message
        # sudo service "${service_name}" restart
    elif [ $thread_status == "FAILED" ]; then
        # echo "WARNING: $(/bin/date) || PID: ${Process_PID} || Current process threads(${OPEN_THREAD}) and threshold(${THREAD_THRESHOLD}) || Process Uptime(m): $((${UPTIME}/60))"  >> "$logpath"
        COLOR=ffff00
        message="WARNING: $process_name Current process threads(${OPEN_THREAD}) are above threshold(${THREAD_THRESHOLD}). Checked at: $TIMECHECK || Uptime: $UPTIME"
        sendalert $message
    else
        getlastupdatedtime
        echo "SUCCESS:ALLGOOD:$pcpu:$pmem:$PFD:$FD_LIMIT:$TIMECHECK:$UPTIME"
        # message="SUCCESS:ALLGOOD:$pcpu:$pmem:$PFD:$FD_LIMIT:$TIMECHECK:$UPTIME"
    fi
fi 
