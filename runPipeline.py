import sys
from datetime import date, timedelta

import duckdb


def run_sql_file(con, path, runDate):
    sql = open(path).read()
    for statement in sql.split(";"):
        if statement.strip():
            con.execute(statement, {"runDate": runDate})



def run_day(con, runDate):
    run_sql_file(con, "sql/loadData-2.sql", runDate)
    run_sql_file(con, "sql/loadQueryTable-3.sql", runDate)
    print(f"Loaded {runDate}")


def main():
    # usage: python run_pipeline.py 2026-10-01 2026-10-03
    start = date.fromisoformat(sys.argv[1])
    end = date.fromisoformat(sys.argv[2]) if len(sys.argv) > 2 else start

    con = duckdb.connect("meta_dwh.duckdb")
    day = start
    while day <= end:
        run_day(con, day)
        day += timedelta(days=1)


if __name__ == "__main__":
    main()