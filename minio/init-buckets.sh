#!/bin/sh
set -e

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