# ELK for Windows in Docker

This repository is purposed for learning and setting up a POC of hosting the [Elastic Stack](https://www.elastic.co/products) on a Windows kernel using Docker.

Special thanks to `Tim Wilde` for the [article](https://www.honeycomb.io/blog/2018/01/simple-structured-logging-with-nlog/) on how to setup NLog and Logstash and also to `SharpSeeEr` for the [repo](https://github.com/SharpSeeEr/Dockerfiles) which explains how to set up ELK on a Windows kernel in Docker.

There is also a test C# application which uses NLog that can be used to log something against the Logstash instance hosted in Docker.

## Before you can start...

1. Download Java for Servers from [Oracle's Java Downloads](http://www.oracle.com/technetwork/java/javase/downloads/server-jre8-downloads-2133154.html) after accepting the license agreement.
2. Extract the tarball to a folder called "sources" in the same folder as the Dockerfile.


## To Run:

> docker images

Look for the `elastic search` and `kibana` images and copy their `Image ID`.

> docker run --name elasticsearch --rm -p 9200:9200 -p 9300:9300 {Elastic Image ID}
>
> docker run --rm --link <Elastic Image ID> -p 5601:5601 {Kibana Image ID}
