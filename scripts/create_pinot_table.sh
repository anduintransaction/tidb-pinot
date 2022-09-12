#!/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`
CONTROLLER_ENDPOINT=${CONTROLLER_ENDPOINT:-http://127.0.0.1:9000}

curl -v -X POST \
  -H "Content-Type: application/json" \
  -d "@${here}/../configs/pinot/schema.json" \
  $CONTROLLER_ENDPOINT/schemas

curl -v -X POST \
  -H "Content-Type: application/json" \
  -d "@${here}/../configs/pinot/table.json" \
  $CONTROLLER_ENDPOINT/tables
