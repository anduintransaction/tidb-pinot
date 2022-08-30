# TiDB Pinot Data Pipeline

### Prerequisite

- [TiUp](https://github.com/pingcap/tiup)
- [docker-compose](https://docs.docker.com/compose/install/)
- [kaf](https://github.com/birdayz/kaf) (optional - for interacting with kafka)

### Setup

- Start TiDB by `./scripts/start_tidb.sh`

- Start docker services by `./scripts/start_docker.sh`. This will boot up these services:

  - A simple Kafka cluster
  - A simple Pinot cluster

- Create TiDB CDC job by `./scripts/create_cdc.sh`. This will export CDC event into kafka using `canal-json` format

- Create a Pinot realtime table with `./scripts/create_pinot_table.sh`

- Seed data into TiDB with `./scripts/seed_db.sh`

- At this moment, CDC events should appear with in kafka. You can check event message by running `kaf -b 127.0.0.1:9092 consume tidb_test_Persons`

- Open Pinot Dashboard at http://localhost:9000/#/query and try your query

### Notes

- In order for Pinot to consume CDC event in `canal-json` format, we use https://github.com/anduintransaction/pinot-plugins
