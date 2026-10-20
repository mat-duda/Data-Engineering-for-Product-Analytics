#How many distinct users queried the table X during a given period?
SELECT COUNT(DISINCT q.userId) AS distinct_users
FROM QueryTable qt
JOIN Query q ON qt.queryId = q.queryId
#X = orders; for example purposes
WHERE qt.tableName = 'orders'
AND q.queryDate BETWEEN '2023-01-01' AND '2023-01-10';







#How many resources did the team Y consume during that period?

