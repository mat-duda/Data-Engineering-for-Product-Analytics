--No duplicates check
SELECT queryId FROM Query GROUP BY queryId HAVING COUNT(*) > 1; 

--No negative values check
SELECT queryId FROM Query WHERE cpuTimeMs < 0 OR bytesScanned < 0;

