DELETE FROM QueryTable WHERE queryDate = $runDate;

INSERT INTO QueryTable
SELECT DISTINCT
    queryId,
    UNNEST(tablesAnalyzed) AS tableName,
    CAST(whenQueried AS DATE)  AS queryDate
FROM RawData
WHERE CAST(whenQueried AS DATE) = $runDate;