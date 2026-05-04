import subprocess

print("Step 1: Generating data...")
subprocess.run(["python", "python/data_generation.py"])

print("Step 2: Loading data into PostgreSQL...")
subprocess.run(["python", "python/load_data.py"])

print("Pipeline completed successfully.")