# ELK for Windows in Docker

This repository is purposed for learning and setting up a POC of hosting the [Elastic Stack](https://www.elastic.co/products) on a Windows kernel using [Docker](https://www.docker.com/).

Special thanks to `Tim Wilde` for the [article](https://www.honeycomb.io/blog/2018/01/simple-structured-logging-with-nlog/) on how to setup NLog and Logstash and also to `SharpSeeEr` for the [repo](https://github.com/SharpSeeEr/Dockerfiles) which explains how to set up ELK on a Windows kernel in Docker.

There is also a test C# application which uses [NLog.StructuredLogging.Json](https://github.com/justeat/NLog.StructuredLogging.Json) that can be used to log something against the Logstash instance hosted in Docker.

## Before you can start...

Run the `setup_sources.ps1` script to make sure all the required applications are accessible to the docker images for build.
This will download the OpenJDK from [https://github.com/ojdkbuild/ojdkbuild](https://github.com/ojdkbuild/ojdkbuild) for running Java on a windows platform as well as the ELK stack binaries.

## Building the images

If you want to make some config changes, view and edit the config files in the relevant app folders first.
Run the `build_all.ps1` script.

## Running the images

Run the "run" scripts in the sequence they are labeled in, in different terminals.

## Running the test

Compile and run the `Logstash Logger` application found in the "tests" folder.

## Checking results

So the test application should have sent a log message to `Logstash` which would eventually propagate it to `Elastic Search` and you should be able to view the results in `Kibana` by browsing to [http://localhost:5601](http://localhost:5601).
