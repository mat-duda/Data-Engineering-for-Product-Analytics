import random 
from datetime import datetime, timedelta
import duckdb

random.seed(42)

teams = [('TA', 'Team A'), ('TB', 'Team B'), ('TC', 'Team C')]

users = [('Anna', 'TA'), ('Bob', 'TB'), ('Charlie', 'TC'), ('David', 'TA'), ('Eva', 'TB')]

tables = ['orders', 'products', 'customers']

queries = []

start_date = datetime(2023, 1, 1)

for i in range(200):
    when_queried = start_date + timedelta(minutes=random.randint(0, 30 * 24 * 60))
    when_received = when_queried + timedelta(seconds=random.randint(1, 120))
    queries.append((
        f"q{i:04d}",
        when_queried,
        when_received,
        random.choice(users)[0],
        random.randint(100, 600_000),               
        random.choice(["FINISHED"] * 9 + ["FAILED"]),  
        random.sample(tables, k=random.randint(1, 3)), 
    ))

queries.append(queries[0])

connection = duckdb.connect(database='meta_dwh.duckdb')

connection.execute("CREATE OR REPLACE TABLE raw_team (teamId VARCHAR, teamName VARCHAR)")
connection.execute("CREATE OR REPLACE TABLE raw_user (userId VARCHAR, teamId VARCHAR)")
connection.execute("""
    CREATE OR REPLACE TABLE raw_query_events (
        queryId        VARCHAR,
        whenQueried    TIMESTAMP,
        whenReceived   TIMESTAMP,
        userId         VARCHAR,
        cpuTimeMs      BIGINT,
        state          VARCHAR,
        tablesAnalyzed VARCHAR[]
    )
""")

connection.executemany("INSERT INTO raw_team VALUES (?, ?)", teams)
connection.executemany("INSERT INTO raw_user VALUES (?, ?)", users)
connection.executemany("INSERT INTO raw_query_events VALUES (?, ?, ?, ?, ?, ?, ?)", queries)

print(connection.execute("SELECT * FROM raw_query_events LIMIT 5").fetchdf())
connection.close()