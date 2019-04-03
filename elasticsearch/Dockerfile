FROM microsoft/nanoserver

ARG ELASTICSEARCH_VERSION=6.7.0

COPY sources /

RUN powershell.exe -Command \
    Expand-Archive -Path \java*.zip -DestinationPath \ ; \
    Remove-Item -Path \java*.zip ;

# Set the JAVA_HOME environment variable to match the version copied in
RUN for /d %i in (java*) do setx /m JAVA_HOME %~fi

# Build variable to allow passing in a specific version of Elasticsearch to download
ARG ELASTICSEARCH_SOURCE=elasticsearch-oss-${ELASTICSEARCH_VERSION}
ENV ELASTICSEARCH_PATH=elasticsearch-${ELASTICSEARCH_VERSION}

# Extract Elasticsearch
RUN powershell.exe -Command \
    Expand-Archive -Path \$($Env:ELASTICSEARCH_SOURCE).zip -DestinationPath \ ; \
    Remove-Item -Path \$($Env:ELASTICSEARCH_SOURCE).zip ;

ENV ELASTIC_HOME C:\\${ELASTICSEARCH_PATH}

COPY elasticsearch.yml ${ELASTIC_HOME}/config/

# Create a data volume and map it to the G: drive, allowing Java to call Path.toRealPath() successfully
VOLUME c:/elastic_data
RUN powershell.exe -Command \
    Set-Variable -Name 'regpath' -Value 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' ; \
    Set-ItemProperty -path $regpath -Name 'G:' -Value '\??\C:\elastic_data' -Type String ;

ENV ES_JAVA_OPTS -Xms512m -Xmx512m

COPY RunElasticSearch.ps1 /
CMD ["powershell", "-File", "C:/RunElasticSearch.ps1"]

EXPOSE 9200 9300