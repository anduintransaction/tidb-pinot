#!/bin/env bash

here=`cd $(dirname $BASH_SOURCE); pwd`

tiup playground --host 0.0.0.0 --db 1 --pd 1 --kv 1 --tiflash 0 --ticdc 1
