#!/usr/bin/bash


PID_RESULT=`pgrep mongo| awk '{print $1}'`  # returns 0 if mongo eval succeeds
#FILTER=$1
#SERVICENAME=$2
HOST=127.0.0.1
PORT=27017
conn_threshold=5
mongo_conn=$(sudo netstat -apn | grep 27017 | wc -l )
#mongo --host $HOST --port $PORT test --eval "printjson(db.version())" > /dev/null 2>&1
WEBHOOK_URL=https://sigmastreamcom.webhook.office.com/webhookb2/8c78ee27-09f8-47d9-a0ba-80cc98d76acb@9c6e8818-9573-4af1-a3f4-2d19bf10a063/IncomingWebhook/4f4369ee48974d199e31f78918f29850/d8146787-3eaa-4062-b82f-845f245f689f

alertstatus=TRUE

function sendalert {
    if [ $alertstatus == "TRUE" ]; then
        MESSAGE=$(echo $message | sed 's/"/\"/g' | sed "s/'/\'/g" )
        IP=$(echo $ip)
        TITLE="`hostname`:- `echo $ip`"
        JSON="{\"title\": \"${TITLE}\", \"themeColor\": \"${COLOR}\", \"text\": \"${message}\" }"
        curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK_URL}"
    else
        return 1
    fi
}


if [ $mongo_conn -le $conn_threshold ] || [ $PID_RESULT -ge 1 ] ; then
    COLOR=ff0000
        message="$(/bin/date)<h1><strong>MongoDB connections are $mongo_conn less than given threshold($conn_threshold), Please check the mongo health immidiately.</strong><h1>"
    sendalert $message
else
        echo ""
fi