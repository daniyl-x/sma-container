# sma-container
This repository contains files required to build container for
<https://github.com/xmig/sys_monitor_agent>.\
The images are hosted on
[dockerhub](https://hub.docker.com/r/daniylx/sys_monitor_agent).

Currently, this is Docker-oriented, but other containers like Podman may be
supported in the future.


## Table of contents
- [Dockerfiles](#dockerfiles)
- [Building images](#building-images)
- [Images](IMAGES.md)


## Dockerfiles
The repo includes Dockerfiles for builds based on different Linux distributions.
Each file has name following the next convention: `Dockerfile.<base OS>`.


## Building images
To build docker images with specific Dockerfile, the name of the file should be
passed using `-f` flag.
The next example demonstrates the build command for Alpine Linux based image:
```sh
docker build -f Dockerfile.alpine -t sys_monitor_agent:alpine .
```

