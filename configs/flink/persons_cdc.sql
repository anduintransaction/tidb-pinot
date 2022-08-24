CREATE TABLE persons_cdc (
  ts TIMESTAMP_LTZ METADATA FROM 'value.ingestion-timestamp' VIRTUAL,
  PersonID INT,
  Name STRING
) WITH (
 'connector' = 'kafka',
 'topic' = 'tidb_test_Persons',
 'properties.bootstrap.servers' = 'kafka:9092',
 'properties.group.id' = 'flink',
 'format' = 'canal-json',
 'scan.startup.mode' = 'earliest-offset',
 'properties.auto.offset.reset' = 'earliest'
);

CREATE TABLE persons_pinot (
  ts BIGINT,
  PersonID INT,
  Name STRING,
  PRIMARY KEY (PersonID) NOT ENFORCED
) WITH (
 'connector' = 'upsert-kafka',
 'topic' = 'pinot_Persons_2',
 'properties.bootstrap.servers' = 'kafka:9092',
 'properties.group.id' = 'flink',
 'key.format' = 'raw',
 'value.format' = 'json'
);
