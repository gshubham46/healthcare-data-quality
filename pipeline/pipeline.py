import subprocess

print("Step 1: Generating data...")
subprocess.run(["python", "python/generate_data.py"])

print("Step 2: Loading data into PostgreSQL...")
subprocess.run(["python", "python/load_to_db.py"])

print("Pipeline completed successfully.")