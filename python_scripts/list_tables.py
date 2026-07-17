from sqlalchemy import create_engine, text

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
        query = """
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public';
        """

        result = connection.execute(text(query))

        print("Tables in LMI database:")

        for table in result:
            print(table[0])

except Exception as e:
    print(e)