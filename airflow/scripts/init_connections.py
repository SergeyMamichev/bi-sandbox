from airflow.models import Connection
from airflow.utils.db import provide_session
import os
import logging
import json

def check_env_vars():
    """Checks that all required environment variables are present."""
    required_vars = [
        "POSTGRES_DWH_USER",
        "POSTGRES_DWH_PASSWORD",
        "POSTGRES_DWH_DB",
        "MINIO_ROOT_USER",
        "MINIO_ROOT_PASSWORD",
    ]
    missing_vars = [var for var in required_vars if var not in os.environ]
    if missing_vars:
        raise EnvironmentError(f"Required environment variables are missing: {', '.join(missing_vars)}")

@provide_session
def init_connections(session=None):
    '''
    Initializes Airflow connections defined in a list of dictionaries.
    Updates existing connections or creates new ones as needed.

    Args:
        session: SQLAlchemy session for database operations (provided by 'provide_session' decorator).
    '''
    # Check environment variables
    check_env_vars()

    # List of connections to create or update
    connections = [
        {
            "conn_id": "dwh_postgres",
            "conn_type": "postgres",
            "host": "postgres_dwh",
            "schema": os.environ.get("POSTGRES_DWH_DB"),
            "login": os.environ.get("POSTGRES_DWH_USER"),
            "password": os.environ.get("POSTGRES_DWH_PASSWORD"),
            "port": 5432,
            "extra": None,
        },
        {
            "conn_id": "minio_s3",
            "conn_type": "s3",
            "host": "http://minio:9000",
            "login": os.environ.get("MINIO_ROOT_USER"),
            "password": os.environ.get("MINIO_ROOT_PASSWORD"),
            "port": None,
            "extra": {
                "aws_access_key_id": os.environ.get("MINIO_ROOT_USER"),
                "aws_secret_access_key": os.environ.get("MINIO_ROOT_PASSWORD"),
                "endpoint_url": "http://minio:9000",
            },
        },
    ]

    for conn_data in connections:
        conn_id = conn_data["conn_id"]
        existing_conn = session.query(Connection).filter(Connection.conn_id == conn_id).first()
        
        if existing_conn:
            logging.info(f"Connection {conn_id} already exists, updating...")
            existing_conn.conn_type = conn_data["conn_type"]
            existing_conn.host = conn_data["host"]
            existing_conn.schema = conn_data.get("schema") # Using get to avoid KeyError
            existing_conn.login = conn_data["login"]
            existing_conn.password = conn_data["password"]
            existing_conn.port = conn_data["port"]
            extra_value = json.dumps(conn_data["extra"]) if conn_data["extra"] else None
            existing_conn.set_extra(extra_value)
        else:
            logging.info(f"Creating new connection: {conn_id}")
            new_conn = Connection(
                conn_id=conn_id,
                conn_type=conn_data["conn_type"],
                host=conn_data["host"],
                schema=conn_data.get("schema"),
                login=conn_data["login"],
                password=conn_data["password"],
                port=conn_data["port"],
                extra=conn_data["extra"],  
            )
            session.add(new_conn)

    logging.info("Committing changes to database...")
    session.commit()
    logging.info("Connections processed successfully!")

if __name__ == "__main__":
    init_connections()    