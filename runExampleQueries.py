import duckdb

con = duckdb.connect("meta_dwh.duckdb")
sql = open("sql/exampleQueries.sql").read()

for statement in sql.split(";"):
    if statement.strip():
        print(statement.strip())
        result = con.sql(statement)
        if result is not None:
            result.show()
        print()
con.close()