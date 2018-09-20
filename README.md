# ELK for Windows in Docker

This repository is purposed for learning and setting up a POC of hosting the [Elastic Stack](https://www.elastic.co/products) on a Windows kernel using Docker.

Special thanks to `Tim Wilde` for the [article](https://www.honeycomb.io/blog/2018/01/simple-structured-logging-with-nlog/) on how to setup NLog and Logstash and also to `SharpSeeEr` for the [repo](https://github.com/SharpSeeEr/Dockerfiles) which explains how to set up ELK on a Windows kernel in Docker.

There is also a test C# application which uses NLog that can be used to log something against the Logstash instance hosted in Docker.

## Before you can start...

1. Download Java for Servers from [Oracle's Java Downloads](http://www.oracle.com/technetwork/java/javase/downloads/server-jre8-downloads-2133154.html) after accepting the license agreement.
2. Extract the tarball to a folder called "sources" in the root of the repo.
3. Run the `setup_jdk.ps1` script to make sure it is accessible to the docker images for build.

## Running the images

Run the "run" scripts in the sequence they are labeled in, in different terminals.

## Runnin the test

Compile and run the application found in the "tests" folder.