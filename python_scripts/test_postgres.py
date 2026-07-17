from sqlalchemy import create_engine, text

import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()

username = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
host = os.getenv("DB_HOST")
port = os.getenv("DB_PORT")
database = os.getenv("DB_NAME")

engine = create_engine(
    f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}"
)

try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT version();"))
        print("Connected successfully!")
        print(result.fetchone())

except Exception as e:
    print("Connection failed:")
    print(e)