FROM microsoft/nanoserver

ARG LOGSTASH_VERSION=6.7.0

COPY sources /

RUN powershell.exe -Command \
    Expand-Archive -Path \java*.zip -DestinationPath \ ; \
    Remove-Item -Path \java*.zip ;

# Set the JAVA_HOME environment variable to match the version copied in
RUN for /d %i in (java*) do setx /m JAVA_HOME %~fi

# Build variable to allow passing in a specific version of LogStash to download
ARG LOGSTASH_SOURCE=logstash-oss-${LOGSTASH_VERSION}
ENV LOGSTASH_PATH=logstash-${LOGSTASH_VERSION}

# Extract LogStash
RUN powershell.exe -Command \
    Expand-Archive -Path \$($Env:LOGSTASH_SOURCE).zip -DestinationPath \ ; \
    Remove-Item -Path \$($Env:LOGSTASH_SOURCE).zip ;

ENV LOGSTASH_HOME C:\\${LOGSTASH_PATH}

COPY elastic.pipeline.conf ${LOGSTASH_HOME}/config/
COPY pipelines.yml ${LOGSTASH_HOME}/config/
COPY logstash.yml ${LOGSTASH_HOME}/config/

# Create a data volume and map it to the G: drive, allowing Java to call Path.toRealPath() successfully
VOLUME c:/logstash_data
RUN powershell.exe -Command \
    Set-Variable -Name 'regpath' -Value 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' ; \
    Set-ItemProperty -path $regpath -Name 'H:' -Value '\??\C:\logstash_data' -Type String ;

ENV ES_JAVA_OPTS -Xms512m -Xmx512m

COPY RunLogstash.ps1 /
CMD ["powershell", "-File", "C:/RunLogstash.ps1"]

EXPOSE 9201