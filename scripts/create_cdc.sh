#!/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`
CDC_ENDPOINT=${CDC_ENDPOINT:-http://127.0.0.1:8300}

curl -v -X POST \
  -H "Content-Type: application/json" \
  -d "@${here}/../configs/tidb/changefeed.json" \
  $CDC_ENDPOINT/api/v2/changefeeds
