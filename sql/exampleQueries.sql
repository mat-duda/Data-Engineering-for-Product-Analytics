--How many distinct users queried the table X during a given period?
--X = orders for example purposes
SELECT COUNT(DISTINCT q.userId) AS distinct_users
FROM QueryTable qt
JOIN Query q ON qt.queryId = q.queryId
WHERE qt.tableName = 'orders'
AND q.queryDate BETWEEN '2023-01-01' AND '2023-01-10';




--How many resources did the team Y consume during that period?
--Y = Team A for example purposes
SELECT t.teamname,
COUNT(*) AS total_queries,
SUM(CASE WHEN q.state = 'FAILED' THEN 1 ELSE 0 END) AS failed_queries,
ROUND(SUM(q.cpuTimeMs)/1000/60, 2) AS total_cpu_time_minutes,
ROUND(SUM(q.bytesScanned)/1e9, 2) AS total_GB_scanned
From Query q 
JOIN User u ON q.userId = u.userId
AND u.validFrom <= q.queryDate
AND u.validTo > q.queryDate
JOIN Team t ON u.teamId = t.teamId
WHERE t.teamName = 'Team A'
AND q.queryDate BETWEEN '2023-01-01' AND '2023-01-10'
GROUP BY t.teamName;
