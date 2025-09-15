# BI Sandbox
A data experimentation playground: building a minimal BI system from the ground up. This repository is my personal lab for learning and practicing the core components of a Business Intelligence stack:
- Data Warehouse (DWH): Schema design and data population.
- ETL/ELT Processes: Data extraction, transformation, and loading.
- Visualization & Reporting: Dashboard setup.
Here, I experiment with various tools, make mistakes, find solutions, and strive to understand how everything works under the hood.

Tech Stack: PostgreSQL, Airflow, S3 (MinIO)

## Quickstart

1. Clone the repository
```sh
git clone https://github.com/SergeyMamichev/bi-sandbox.git
```

2. Navigate to project directory
```sh
cd study-dwh-etl-bi
```

3. Environment configuration
Create .env file in the project root and configure it using .env.example as a template:
```bash
cp .env.example .env
# Edit the .env file with your values
```

4. Start Airflow
Execute in terminal sequentially:
```sh
docker-compose up airflow-init
docker-compose up -d
```
