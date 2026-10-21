import random 
from datetime import date, datetime, timedelta
import duckdb

random.seed(42)

forever = date(9999, 12, 31)

teams = [('TA', 'Team A'), 
         ('TB', 'Team B'), 
         ('TC', 'Team C'),
         ('UNASSIGNED', 'UNASSIGNED')
         ]

users = [('Anna', 'TA',date(2023, 1, 1), date(2023, 1, 5)),
         ('Anna', 'TB',date(2023, 1, 5), forever), 
         ('Bob', 'TB',date(2023, 1, 1), forever), 
         ('Charlie', 'TC',date(2023, 1, 1), forever),
           ('David', 'TA',date(2023, 1, 1), forever), 
           ('Eva', 'TB',date(2023, 1, 1), forever)
           ]

tables = ['orders', 'products', 'customers']

user_ids = ['Anna', 'Bob', 'Charlie', 'David', 'Eva']

queries = []

start_date = datetime(2023, 1, 1)

for i in range(200):
    when_queried = start_date + timedelta(minutes=random.randint(0, 30 * 24 * 60))
    when_received = when_queried + timedelta(seconds=random.randint(1, 120))
    queries.append((
        f"q{i:04d}",
        when_queried,
        when_received,
        random.choice(user_ids),
        random.randint(100, 600_000),
        random.randint(1_000_000, 50_000_000_000),
        random.choice(["FINISHED"] * 9 + ["FAILED"]),  
        random.sample(tables, k=random.randint(1, 3)), 
    ))

queries.append(queries[0])

queries.append((
    "q9999",
    datetime(2023, 1, 5, 3, 0),
    datetime(2023, 1, 5, 3, 1),
    'Unknown',
    120_000,
    10_000_000_000,
    "FINISHED",
    ['orders'],
))

connection = duckdb.connect(database='meta_dwh.duckdb')
connection.execute(open("sql/1-createTables.sql").read())


connection.execute("DELETE FROM RawData")
connection.execute("DELETE FROM Team")
connection.execute("DELETE FROM User")

connection.executemany("INSERT INTO Team VALUES (?, ? )", teams)
connection.executemany("INSERT INTO User VALUES (?, ?,?,?)", users)
connection.executemany("INSERT INTO RawData VALUES (?, ?, ?, ?, ?, ?, ?, ?)", queries)

connection.sql("SELECT * FROM RawData LIMIT 5").show()
connection.close()