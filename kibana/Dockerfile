FROM microsoft/windowsservercore

# Build variable to allow passing in a specific version of Elasticsearch to download
ARG KIBANA_VERSION=6.7.0
ARG KIBANA_SOURCE=kibana-oss-${KIBANA_VERSION}-windows-x86_64
ARG KIBANA_PATH=kibana-${KIBANA_VERSION}-windows-x86_64

COPY sources /

# Extracting the archive can take a while unless this step is cached already
RUN powershell.exe -Command \
  Expand-Archive -Path \$($Env:KIBANA_SOURCE).zip -DestinationPath \ ; \
  Remove-Item -Path \$($Env:KIBANA_SOURCE).zip;

# ELASTIC_HOME is used by the runelasticsearch.cmd file to launch Elasticsearch.
ENV KIBANA_HOME C:\\${KIBANA_PATH}

COPY kibana.yml /${KIBANA_PATH}/config/

COPY RunKibana.ps1 /
CMD ["powershell", "-File", "C:/RunKibana.ps1"]

EXPOSE 5601