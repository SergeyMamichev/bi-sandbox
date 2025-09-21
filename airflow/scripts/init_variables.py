from airflow.models import Variable
from airflow.utils.db import provide_session
import os
import logging

def check_env_vars():
    """Checks that all required environment variables are present."""
    required_vars = [
        "WEATHER_API_KEY"
    ]
    missing_vars = [var for var in required_vars if var not in os.environ]
    if missing_vars:
        raise EnvironmentError(f"Required environment variables are missing: {', '.join(missing_vars)}")

@provide_session
def init_variables(session=None):
    '''
    Initializes Airflow variables defined in a list of dictionaries.
    Updates existing variables or creates new ones as needed.

    Args:
        session: SQLAlchemy session for database operations.
    '''
    # Check environment variables
    check_env_vars()

    # List of variables to create or update
    variables = [
        {
            "key": "weather_api_key",
            "value": os.environ.get("WEATHER_API_KEY"),
            "description": "Weather API key for data ingestion"
        }
    ]

    for var_data in variables:
        var_key = var_data["key"]
        existing_var = session.query(Variable).filter(Variable.key == var_key).first()
        
        if existing_var:
            logging.info(f"Variable {var_key} already exists, updating...")
            existing_var.set_val(var_data["value"])
            existing_var.description = var_data.get("description", "")
        else:
            logging.info(f"Creating new variable: {var_key}")
            new_var = Variable(
                key=var_key,
                val=var_data["value"],
                description=var_data.get("description", "")
            )
            session.add(new_var)

    logging.info("Committing variable changes to database...")
    session.commit()
    logging.info("Variables processed successfully!")

if __name__ == "__main__":
    init_variables()