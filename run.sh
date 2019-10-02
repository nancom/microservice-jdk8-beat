#!/bin/sh
echo "-= start script =-"
echo 'java option :' $J_OPTS
echo '-= Run Filebeat =-'
exec /opt/filebeat/filebeat -e -c /opt/filebeat/filebeat.yml -d "publish" &
echo '-= Run Flight =-'
java -jar $J_OPTS /opt/app/run.jar &
echo '-= Run Application =-'
java -jar $J_OPTS /opt/app/run2.jar >> /opt/logs/test.log
