--How many distinct users queried the table X during a given period?
--X = orders for example purposes
SELECT COUNT(DISTINCT q.userId) AS distinct_users
FROM QueryTable qt
JOIN Query q ON qt.queryId = q.queryId
WHERE qt.tableName = 'orders'
AND q.queryDate BETWEEN '2023-01-01' AND '2023-01-10';




--How many resources did the team Y consume during that period?
--Y = Team A for example purposes
SELECT t.teamName,
COUNT(*) AS total_queries,
SUM(CASE WHEN q.state = 'FAILED' THEN 1 ELSE 0 END) AS failed_queries,
ROUND(SUM(q.cpuTimeMs)/1000/60, 2) AS total_cpu_time_minutes,
ROUND(SUM(q.bytesScanned)/1e9, 2) AS total_GB_scanned
FROM Query q
LEFT JOIN User u ON q.userId = u.userId
               AND q.queryDate >= u.validFrom
               AND q.queryDate <  u.validTo
JOIN Team t ON t.teamId = COALESCE(u.teamId, 'UNASSIGNED')
WHERE t.teamName = 'Team A'
AND q.queryDate BETWEEN '2023-01-01' AND '2023-01-10'
GROUP BY t.teamName;

--Top 5 most used tables during that period
SELECT tableName,
COUNT(*) AS query_count
FROM QueryTable
WHERE queryDate BETWEEN '2023-01-01' AND '2023-01-10'
GROUP BY tableName
ORDER BY query_count DESC
LIMIT 5;

--Failure rate per team
SELECT t.teamName,
COUNT(*) AS total_queries,
ROUND(100.0 * SUM(CASE WHEN q.state = 'FAILED' THEN 1 ELSE 0 END) / COUNT(*), 1) AS failure_rate_percent
FROM Query q
LEFT JOIN User u ON q.userId = u.userId
               AND q.queryDate >= u.validFrom
               AND q.queryDate <  u.validTo
JOIN Team t ON t.teamId = COALESCE(u.teamId, 'UNASSIGNED')
GROUP BY t.teamName
ORDER BY failure_rate_percent DESC;