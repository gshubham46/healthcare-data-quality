import psycopg2

try:
    conn = psycopg2.connect(
        dbname="healthcare_db",
        user="postgres",
        password="nimda",
        host="localhost",
        port="5432"
    )

    print("Database connection successful!")

    conn.close()

except Exception as e:
    print(f"Database connection failed: {e}")