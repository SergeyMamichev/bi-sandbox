#!/bin/sh
set -e

# Run MinIO in the background and save the PID
minio server /data --console-address ':9001' & PID=$!

echo "Waiting for MinIO to be ready..."
while ! curl -s http://localhost:9000/minio/health/live > /dev/null; do
    sleep 1
done

echo "MinIO is ready, initializing it..."
/init-buckets.sh

echo "Stopping the MinIO background process (PID: $PID)..."
kill $PID
wait $PID  # Wait for the process to complete to avoid zombie processes

echo "Running MinIO in foreground..."
exec minio server /data --console-address ':9001'