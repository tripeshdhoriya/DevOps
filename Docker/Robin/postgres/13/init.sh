#!/bin/bash

set -e

echo "Starting init.sh..."

# Wait for PostgreSQL to be available
until pg_isready -h localhost -U postgres; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

echo "PostgreSQL is ready"

# Check if initialization has been done before
if [ ! -f /var/lib/postgresql/data/.init_done ]; then
  #echo "Running db.sql..."
  #psql -U postgres -d postgres -f /docker-entrypoint-initdb.d/db.sql

  echo "Restoring from custom-format dump file: rtv.dump"
  pg_restore -U rtv -d rtv /docker-entrypoint-initdb.d/rtv.dump

  # Create a marker file to indicate initialization is done
  touch /var/lib/postgresql/data/.init_done

  echo "init.sh completed."
else
  echo "Initialization already done, skipping."
fi
