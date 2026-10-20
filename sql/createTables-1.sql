CREATE TABLE IF NOT EXISTS RawData (
    queryId         VARCHAR,
    whenQueried     TIMESTAMP,
    whenReceived    TIMESTAMP,
    userId          VARCHAR,
    cpuTimeMs       BIGINT,
    bytesScanned    BIGINT,
    state           VARCHAR,
    tablesAnalyzed  VARCHAR[]
);

CREATE TABLE IF NOT EXISTS Team (
    teamId          VARCHAR,
    teamName        VARCHAR
);

CREATE TABLE IF NOT EXISTS User (
    userId          VARCHAR,
    teamId          VARCHAR
);

CREATE TABLE IF NOT EXISTS Query (
    queryId         VARCHAR,
    userId          VARCHAR,
    queryDate       DATE,
    whenQueried     TIMESTAMP,
    cpuTimeMs       BIGINT,
    bytesScanned    BIGINT,
    state           VARCHAR
);

CREATE TABLE IF NOT EXISTS QueryTable (
    queryId         VARCHAR,
    tableName       VARCHAR,
    queryDate       DATE
);
