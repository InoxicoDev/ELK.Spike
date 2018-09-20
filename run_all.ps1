docker run --name elasticsearch --rm -p 9200:9200 -p 9300:9300 elasticsearch
docker run --name kibana --link elasticsearch --rm -p 5601:5601 kibana
docker run --name logstash --link elasticsearch --rm -p 9201:9201 logstash