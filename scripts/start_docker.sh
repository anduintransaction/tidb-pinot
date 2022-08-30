#!/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`

function findMachineIP() {
  ip route get 8.8.8.8 | head -1 | awk '{print $7}'
}

export MACHINE_IP=${MACHINE_IP:-`findMachineIP`}

echo "Using machine ip: ${MACHINE_IP}"
docker-compose -f $here/../docker-compose.yaml up -d
