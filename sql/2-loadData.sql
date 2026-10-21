DELETE FROM Query WHERE queryDate = $runDate;

INSERT INTO Query 
SELECT
 queryId,
 userId, 
CAST(whenQueried AS DATE) AS queryDate,
 whenQueried, 
 cpuTimeMs,
 bytesScanned, 
 state
FROM (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY queryId ORDER BY whenReceived DESC) AS rn
    FROM RawData
    WHERE CAST(whenQueried AS DATE) = $runDate
)
WHERE rn = 1;