DELETE FROM Query WHERE queryDate = $run_date;

INSERT INTO Query 
SELECT
 queryId,
 userId, 
CAST(whenReceived AS DATE) AS queryDate,
 whenQueried, 
 whenReceived,
 cpuTimeMs,
 bytesScanned, 
 state
FROM (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY queryId ORDER BY whenReceived DESC) AS rn
    FROM RawData
    WHERE CAST(whenReceived AS DATE) = $run_date
)
WHERE rn = 1;