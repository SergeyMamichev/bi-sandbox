#!/bin/bash
set -e  # Abort execution on any error
set -x  # Print commands before execution for debugging

echo "Starting Airflow database migration..."
airflow db migrate

echo "Creating administrator user..."
if ! airflow users create \
    --username "${AIRFLOW_ADMIN_USERNAME}" \
    --firstname "${AIRFLOW_ADMIN_FIRSTNAME}" \
    --lastname "${AIRFLOW_ADMIN_LASTNAME}" \
    --role Admin \
    --email "${AIRFLOW_ADMIN_EMAIL}" \
    --password "${AIRFLOW_ADMIN_PASSWORD}" 2> /tmp/user_create_error.log; then
    echo "Error creating user:"
    cat /tmp/user_create_error.log
    exit 1
fi

echo "Running init_connections.py script..."
if ! python /opt/airflow/scripts/init_connections.py 2> /tmp/init_connections_error.log; then
    echo "Error executing init_connections.py:"
    cat /tmp/init_connections_error.log
    exit 1
fi

echo "Running init_variables.py script..."
if ! python /opt/airflow/scripts/init_variables.py 2> /tmp/init_variables_error.log; then
    echo "Error executing init_variables.py:"
    cat /tmp/init_variables_error.log
    exit 1
fi

echo "Airflow initialization complete!"