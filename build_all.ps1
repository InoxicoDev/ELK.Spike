. "./scripts/sources_common.ps1"

Push-Location elasticsearch
docker build --tag elasticsearch --build-arg ELASTICSEARCH_VERSION=$TargetVersionELK .
Pop-Location

Push-Location logstash
docker build --tag logstash --build-arg LOGSTASH_VERSION=$TargetVersionELK .
Pop-Location

Push-Location kibana
docker build --tag kibana --build-arg KIBANA_VERSION=$TargetVersionELK .
Pop-Location