import pandas as pd
import psycopg2

df = pd.read_csv("data/raw/patients.csv")

conn = psycopg2.connect(
    dbname="healthcare_db",
    user="postgres",
    password="nimda",
    host="localhost",
    port="5432"    
)

cur = conn.cursor()

for _, row in df.iterrows():
    cur.execute("""
        INSERT INTO patients (first_name, last_name, date_of_birth, gender, email, phone, created_at)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, (row["first_name"], 
          row["last_name"], 
          row["date_of_birth"], 
          row["gender"], 
          None if pd.isna(row['email']) else row['email'], 
          row["phone"], 
          row["created_at"]
        ))

conn.commit()
cur.close()
conn.close()

print("Data loaded into database successfully!")