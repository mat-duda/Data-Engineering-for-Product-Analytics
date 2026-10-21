--No duplicates check
SELECT queryId FROM QueryTable  GROUP BY queryId HAVING COUNT(*) > 1; 