Create TABLE if not exist RawData (
    queryId         VARCHAR,
    userId          VARCHAR,
    startTime       TIMESTAMP,
    endTime         TIMESTAMP,
    receivedAt      TIMESTAMP,
    state           VARCHAR,
    cpuTimeMs       BIGINT,
    tablesAnalyzed  VARCHAR[] 
);



Create table if not exist Team(
    teamId          VARCHAR,
    teamName        VARCHAR,
);

Create table if not exist User(
    userId          VARCHAR,
    teamName        VARCHAR,
);

Create table if not exist Query(
    queryId         VARCHAR,
    userId          VARCHAR,
    startTime       TIMESTAMP,
    endTime         TIMESTAMP,
    receivedAt      TIMESTAMP,
    state           VARCHAR,
    cpuTimeMs       BIGINT,
    tablesAnalyzed  VARCHAR[] 
);

Create table if not exist QueryTable(
    queryId         VARCHAR,
    tableName       VARCHAR,
);

