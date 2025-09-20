#!/bin/sh
set -e

minio server /data --console-address ":9001" &

echo "Waiting for MinIO to start..."
while ! curl -s http://localhost:9000/minio/health/live > /dev/null; do
    sleep 1
done

echo "Setting up MinIO client..."
mc alias set myminio http://localhost:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD}

buckets="weather-api test-bucket"
for bucket in $buckets; do
    if ! mc ls myminio/${bucket} > /dev/null 2>&1; then
        echo "Creating bucket: ${bucket}"
        mc mb myminio/${bucket}
    else
        echo "Bucket ${bucket} already exists"
    fi
done

mc anonymous set private myminio/weather-api
mc anonymous set private myminio/test-bucket

echo "MinIO initialization completed"
wait