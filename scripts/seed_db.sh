#!/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`

docker run --rm -it --entrypoint="" --network=host \
  -v "$here/../configs/tidb/seed.sql:/opt/anduin/seed.sql" \
  mysql:5.7 \
  bash -c "mysql -h 127.0.0.1 -P 4000 -u root < /opt/anduin/seed.sql"
