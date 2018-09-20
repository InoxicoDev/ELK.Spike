FROM microsoft/windowsservercore

# Build variable to allow passing in a specific version of Elasticsearch to download
ARG KIBANA_VERSION=6.4.1
ARG KIBANA_SOURCE=kibana-oss-${KIBANA_VERSION}-windows-x86_64
ARG KIBANA_PATH=kibana-${KIBANA_VERSION}-windows-x86_64

SHELL ["powershell.exe", "-Command"]

# Download and extract Kibana
ADD ["https://artifacts.elastic.co/downloads/kibana/${KIBANA_SOURCE}.zip", "/"]

# Extracting the archive can take a while unless this step is cached already
RUN powershell.exe -Command \
  Expand-Archive -Path \$($Env:KIBANA_PATH).zip -DestinationPath \ ; \
  Remove-Item -Path \$($Env:KIBANA_PATH).zip;

# ELASTIC_HOME is used by the runelasticsearch.cmd file to launch Elasticsearch.
ENV KIBANA_HOME C:\\${KIBANA_PATH}

COPY kibana.yml /${KIBANA_PATH}/config/

COPY RunKibana.ps1 /
CMD ["powershell", "-File", "C:/RunKibana.ps1"]

EXPOSE 5601