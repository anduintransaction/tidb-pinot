CREATE TABLE persons_cdc (
  PersonID INT,
  Name STRING
) WITH (
 'connector' = 'kafka',
 'topic' = 'tidb_test_Persons',
 'properties.bootstrap.servers' = 'kafka:9092',
 'properties.group.id' = 'flink',
 'format' = 'canal-json',
 'scan.startup.mode' = 'earliest-offset'
);

CREATE TABLE persons_pinot (
  PersonID INT,
  Name STRING
) WITH (
 'connector' = 'kafka',
 'topic' = 'pinot_Persons',
 'properties.bootstrap.servers' = 'kafka:9092',
 'properties.group.id' = 'flink',
 'key.format' = 'raw',
 'key.fields' = 'PersonID',
 'value.format' = 'json'
);
