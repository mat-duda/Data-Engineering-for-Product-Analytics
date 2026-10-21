import sys

import duckdb

con = duckdb.connect("meta_dwh.duckdb")
sql = open("sql/5-testQueries.sql").read()

failed = 0
for statement in sql.split(";"):
    if not statement.strip():
        continue
    name = statement.strip().splitlines()[0].lstrip("-")
    rows = con.execute(statement).fetchall()
    if rows:
        failed += 1
        print(f"FAIL  {name}: {rows[:5]}")
    else:
        print(f"OK    {name}")

con.close()

print(f"Total failed: {failed}")
sys.exit(1 if failed else 0)