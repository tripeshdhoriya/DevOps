#!/bin/bash
pgpass="Password_here"
output_file="/tmp/postgresql-active-transaction-monitor.log"
WEBHOOK_URL=WEBHOOK_URL
alertstatus="TRUE"
export PGPASSWORD=$pgpass

function query(){
    psql -U username -h host -d postgres -tAc "select pid as process_id,usename as username,datname as database_name,client_addr as client_address,application_name,backend_start,state,state_change from pg_stat_activity;" > $output_file
}

# query
function sendalert {
    if [ $alertstatus == "TRUE" ]; then
        MESSAGE=$(echo $message | sed 's/"/\"/g' | sed "s/'/\'/g" )
        # IP=$(echo $ip)
        # TITLE="`hostname`:- `echo $ip`"
        TITLE="Chevron Azure PostgreSQL:- Transaction Detail"
        JSON="{\"title\": \"${TITLE}\", \"themeColor\": \"${COLOR}\", \"text\": \"${message}\" }"
        curl -H "Content-Type: application/json" -d "${JSON}" "${WEBHOOK_URL}"
    else
        return 1
    fi
}

query
total_transactions=$(wc -l $output_file | awk '{print $1}')

#Active Connectinon Parsing
total_active_trans=$(grep -ic "active" $output_file)
rockpigeon_active_transactions=$(grep -i "active" $output_file | grep -ic "kingfisher")
hummingbird_active_transactions=$(grep -i "active" $output_file | grep -ic "KFSeed")
yellowhammer_active_transactions=$(grep -i "active" $output_file | grep -ic "yellowhammer")
postgres_active_transactions=$(grep -i "active" $output_file | grep -ic "postgres")
# azure_active_transactions=$(grep -i "azure_sys" $output_file | grep -ic "azure_superuser")
rtv_active_transactions=$(grep -i "active" $output_file | grep -ic "rtv")

#Idle Connection Parsing
total_idle_trans=$(grep -ic "idle" $output_file)
rockpigeon_ideal_transactions=$(grep -i "idle" $output_file | grep -ic "kingfisher")
hummingbird_ideal_transactions=$(grep -i "idle" $output_file | grep -ic "KFSeed")
yellowhammer_ideal_transactions=$(grep -i "idle" $output_file | grep -ic "yellowhammer")
postgres_ideal_transactions=$(grep -i "idle" $output_file | grep -c "postgres")
azure_ideal_transactions=$(grep -ic "azure_sys" $output_file)
rtv_ideal_transactions=$(grep -i "idle" $output_file | grep -ic "rtv")

let total_idle_trans=$total_idle_trans+$azure_ideal_transactions

#Crafting the message
message="<h1><strong>Total Transactions=${total_transactions}</strong><h1><br><pre><br><strong>Total Active=${total_active_trans}</strong><br>RockPigeon Active Conn=${rockpigeon_active_transactions}<br>HummingBird Active Conn=${hummingbird_active_transactions}<br>YellowHammer Active Conn=${yellowhammer_active_transactions}<br>PostgreSQL Active Conn=${postgres_active_transactions}<br>RTV Active Conn=${rtv_active_transactions}<br><br><br><strong>Total Idle=${total_idle_trans}</strong><br>RockPigeon Idle Conn=${rockpigeon_ideal_transactions}<br>HummingBird Idle Conn=${hummingbird_ideal_transactions}<br>YellowHammer Idle Conn=${yellowhammer_ideal_transactions}<br>PostgreSQL Idle Conn=${postgres_ideal_transactions}<br>Azure Idle Conn=${azure_ideal_transactions}<br>RTV Idle Conn=${rtv_ideal_transactions}</pre>"

sendalert "$message"



