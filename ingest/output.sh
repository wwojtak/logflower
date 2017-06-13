#!/bin/bash

# 1. Find files modify more than 2 minutes ago and insert to clickhouse DB
# 2. In case of errors don't delete the input files

set -eu
find /root/lf/ -mmin +2 -print0 | xargs -0 cat | clickhouse-client --query="INSERT INTO flowlogs FORMAT CSV"
find /root/lf/ -mmin +2 -exec rm {} \;
