DELETE FROM QueryTables WHERE queryDate = $runDate;

INSERT INTO QueryTables
SELECT DISTINCT
    queryId,
    UNNEST(tablesAnalyzed) AS tableName,
    CAST(endTime AS DATE)  AS queryDate
FROM RawData
WHERE CAST(endTime AS DATE) = $runDate;