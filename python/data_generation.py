import pandas as pd
import numpy as np
from faker import Faker
import random

fake = Faker()

records = []
for _ in range(2000):
    records.append({
        "first_name": fake.first_name(),
        "last_name": fake.last_name(), 
        "date_of_birth": fake.date_of_birth(),
        "gender": random.choice(['M', 'F']),
        "email": fake.email() if random.random() > 0.15 else None,
        "phone": fake.phone_number(),
        "created_at": fake.date_time_this_year()
    })

df = pd.DataFrame(records)

df = pd.concat([df, df.sample(frac=0.05)])

df.to_csv("data/raw/patients.csv", index=False)
print("Data generation complete. File saved to data/raw/patients.csv")

# print(df['email'].isnull().sum())
