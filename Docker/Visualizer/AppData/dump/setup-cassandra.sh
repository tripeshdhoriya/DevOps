#!/bin/bash

# Start Cassandra in the background
docker-entrypoint.sh "$@" &

# Function to check if Cassandra is up and running
check_cassandra_status() {
    cqlsh -e "DESCRIBE KEYSPACES;" 2>&1 | grep "Connection error"
}

# Wait for Cassandra to start (up to 3 minutes)
for ((i=0; i<180; i++)); do
    if check_cassandra_status; then
        echo "Cassandra is not yet available. Waiting..."
        sleep 1
    else
        echo "Cassandra is up and running. Proceeding with setup..."
        break
    fi
done


echo "[+] Starting schema restoration..."
cd /cassandra/dump/
cqlsh < hummingbird_kf_schema.cql
echo "[+] Cassandra schema restoration is successfully completed."