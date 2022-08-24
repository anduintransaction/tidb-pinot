#!/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`

tiup cdc cli changefeed create \
  --pd="http://127.0.0.1:2379" \
  --changefeed-id="kafka-changefeed" \
  --sink-uri="kafka://127.0.0.1:9092/kafka-pinot-cdc?protocol=maxwell" \
  --config="${here}/../configs/tidb/changefeed.conf"
