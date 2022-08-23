#!/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`

tiup cdc cli changefeed create --pd="http://127.0.0.1:2379" --sink-uri="kafka://127.0.0.1:9092/kafka-pinot-cdc?protocol=canal-json" --changefeed-id="kafka-changefeed" --config="${here}/../configs/tidb/changefeed.conf"
