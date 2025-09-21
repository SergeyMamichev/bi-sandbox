#!/bin/bash

echo "Running Flyway migrations..."

if [ -z "$POSTGRES_DWH_DB" ] || [ -z "$POSTGRES_DWH_USER" ] || [ -z "$POSTGRES_DWH_PASSWORD" ]; then
  echo "Error: One or more required environment variables are not set."
  exit 1
fi

envsubst < /flyway/conf/flyway.conf > /flyway/conf/flyway-resolved.conf

# Run migrations
/flyway/flyway -configFiles=/flyway/conf/flyway-resolved.conf migrate

echo "Migrations completed!"