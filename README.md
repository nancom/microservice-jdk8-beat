# microservice-jdk8-beat
Spring boot with file beat
#### For main docker microservices
```bash
$ docker pull nancom/microservice-jdk8-filebeat
```

#### Sample command 
```bash
$ docker run --rm --name microservices-sample -p 8888:8080 -v ./filebeat.yml:/opt/filebeat/filebeat.yml -v ./run.sh:/opt/app/run.sh -v ./gs-spring-boot-0.1.0.jar:/opt/app/run.jar -v /tmp/logs/:/opt/logs/ nancom/microservice-jdk8-filebeat
```


### run.sh command for run microservices application 
```
#!/bin/sh
echo "-= start script =-"
echo 'java option :' $J_OPTS

echo '-= Run Filebeat =-'
exec /opt/filebeat/filebeat -e -c /opt/filebeat/filebeat.yml -d "publish" &

echo '-= Run Deamon =-'
java -jar $J_OPTS /opt/app/run.jar &

echo '-= Run Application =-'
java -jar $J_OPTS /opt/app/run2.jar >> /opt/logs/test.log
```



### filebeat.yml config file for setup log reader and forward 
```
filebeat.inputs:
- type: log

  # Change to true to enable this input configuration.
  enabled: true

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /opt/logs/*.log
...

#----------------------------- Logstash output --------------------------------
output.logstash:
  # The Logstash hosts
  hosts: ["host.docker.internal:5044"]

```

### spring boot application 
```bash
$ curl -i X GET http://localhost:8888/
```
```bash
$ curl -i X GET http://localhost:8888/msg?desc=someDataTest
```