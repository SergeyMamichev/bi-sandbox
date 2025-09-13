# study-dwh-etl-bi
A study project to explore modern ETL, DWH, and BI concepts. Implements a data pipeline built with Apache Airflow and Python, extracting data from sources, transforming it, and loading into a PostgreSQL data warehouse for analysis.

## Quickstart

1. Clone the repository
```sh
git clone https://github.com/SergeyMamichev/study-dwh-etl-bi.git
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
