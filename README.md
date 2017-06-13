# logflower
View AWS flow logs using clickhouse and grafana

Fast and *not very* complicated way to view network logs from AWS.
The workflow is VPC Flow Logs -> CloudWatch -> Stream to Lambda -> Send to clickhouse server -> Decompress and ingest to DB -> View in Grafana

1. Start by installing clickhouse, grafana, define schema, install clickhouse plugin for grafana and import dashboard. 
    - Clickhouse - https://clickhouse.yandex/#quick-start
    - Schema - In clickhouse/schema
    - Grafana plugin - https://grafana.com/plugins/vertamedia-clickhouse-datasource/installation
    - Dashboard - grafana/dashboard.json
1. Create new Lambda function as in lambda/forwarder.py **Adjust IP and PORT**
1. Add server-side scripts:
    - For receiving logs and saving extracted lines: ingest/input.sh
    - For batch-inserting logs: ingest/output.sh **Add cron job to do this every X minutes**
1. Enable flow logs in VPC dashboard (Select VPC -> Flow Logs -> Create Flow Log). **Enable only logs with state ACCEPT**
1. In CloudWatch Logs select previously created Log Group and select Stream to Lambda. Select function from step 3.

Sample dashboard with data:
![Dashboard](http://i.imgur.com/EAzVYvB.png)
