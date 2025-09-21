#!/bin/bash
set -e

echo "POSTGRES_DWH_USER: $POSTGRES_DWH_USER"
echo "POSTGRES_DWH_PASSWORD: $POSTGRES_DWH_PASSWORD"
echo "POSTGRES_DWH_DB: $POSTGRES_DWH_DB"

# Run a standard Postgres entrypoint in the background
exec /usr/local/bin/docker-entrypoint.sh "$@" &

until pg_isready -h localhost -p 5432 -U "${POSTGRES_DWH_USER}" -d "${POSTGRES_DWH_DB}"; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

echo "PostgreSQL is ready! Running migrations..."

# Run migrations
/scripts/run_migrations.sh

# Waiting for the main process to complete
wait