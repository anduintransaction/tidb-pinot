CREATE TABLE Persons (
    PersonID INTEGER,
    FirstName STRING,
    LastName STRING,
    Address STRING,
    City STRING
) WITH (
'connector' = 'kafka',
'topic' = 'tidb_test_Persons',
'properties.bootstrap.servers' = '10.21.56.18:9092',
'properties.group.id' = 'flink',
'format' = 'canal-json',
'scan.startup.mode' = 'earliest-offset',
'properties.auto.offset.reset' = 'earliest'
);
