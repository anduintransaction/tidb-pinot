#!/bin/env bash

docker exec tidb-pinot-pinot-controller-1 \
  /opt/pinot/bin/pinot-admin.sh AddTable \
  -schemaFile=/config/schema.json \
  -tableConfigFile=/config/table.json \
  -exec
