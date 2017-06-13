#!/bin/bash

# 1. Start netcat server on specified port
# 2. Decode base64
# 3. Decompress gzip
# 4. Extract the message with jq
# 5. Modify the fields to match what we defined in clickhouse DB
# 6. Save to file to allow archiving, keep backup in case import fails and to
#    batch-import instead of line by line

PORT=1234
DIR=/root/lf

netcat -lkd $PORT | base64 --decode | zcat | jq -r '.["logEvents"][].message' | awk -F' ' '{print strftime("%Y-%m-%d", $11)","strftime("%Y-%m-%d %H:%M:%S", $11)","$3","$4","$5","$6","$7","$8","$9","$10","$11","$12}' \
	| while read line; do
	echo "$line" >> $DIR/$(date +"%Y%m%d%H%M")
done
