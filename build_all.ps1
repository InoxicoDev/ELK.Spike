Push-Location elasticsearch
docker build --tag elasticsearch .
Pop-Location
Push-Location kibana
docker build --tag kibana .
Pop-Location
Push-Location logstash
docker build --tag logstash .
Pop-Location