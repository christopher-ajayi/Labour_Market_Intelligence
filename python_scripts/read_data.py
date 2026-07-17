from sqlalchemy import create_engine
import pandas as pd

import os
from dotenv import load_dotenv

load_dotenv()

username = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
database = os.getenv("DB_NAME")

engine = create_engine(
    f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}"
)

query = """
SELECT *
FROM job_postings_fact
LIMIT 10;
"""

df = pd.read_sql(query, engine)

print(df.head())
print(df.info())