# ELK for Windows in Docker

This repository is purposed for learning and setting up a POC of hosting the [Elastic Stack](https://www.elastic.co/products) on a Windows kernel using [Docker](https://www.docker.com/).

It was later updated so that it actually can run a version of ELK on Docker for a Windows Server environment which cannot use Hyper-V to host Linux containers.

Special thanks to `Tim Wilde` for the [article](https://www.honeycomb.io/blog/2018/01/simple-structured-logging-with-nlog/) on how to setup NLog and Logstash and also to `SharpSeeEr` for the [repo](https://github.com/SharpSeeEr/Dockerfiles) which explains how to set up ELK on a Windows kernel in Docker.

There is also a test C# application which uses [NLog.StructuredLogging.Json](https://github.com/justeat/NLog.StructuredLogging.Json) that can be used to log something against the Logstash instance hosted in Docker.

## Disclaimer

The author or his affiliates do not accept any responsibility for this repo or the Docker images built by it. Feel free to use for your own purposes and at own risk.

## Before you can start...

Make sure you have [docker](https://hub.docker.com/editions/community/docker-ce-desktop-windows) installed (with compose).

Run the `setup_sources.ps1` script to make sure all the required applications are accessible to the docker images for build.
This will download the OpenJDK from [https://github.com/ojdkbuild/ojdkbuild](https://github.com/ojdkbuild/ojdkbuild) for running Java on a windows platform as well as the ELK stack binaries.

## Building and Running the images

Invoke the `run_all.ps1` script to run `docker-compose` which will build the images (if it isn't built already) and then run them.

## Producing a test log

Compile and run the `Logstash Logger` application found in the "tests" folder.

## Checking results

So the test application should have sent a log message to `Logstash` which would eventually propagate it to `Elastic Search` and you should be able to view the results in `Kibana` by browsing to [http://localhost:5601](http://localhost:5601).

## Troubleshooting

In the event that you encounter the following problems, here are some solutions:

> ERROR: for kibana  Cannot start service kibana: network ...long string id... not found

Try and run: `docker-compose down`
