# Description
This repo contains images built for <https://github.com/xmig/sys_monitor_agent>.

The source for dockerfiles can be found at
<https://github.com/daniyl-x/sma-container>.


## Table of contents
- [Tags](#tags)
- [Environment variables](#environment-variables)
- [Usage](#usage)
    - [docker-compose](#docker-compose)
    - [docker-cli](#docker-cli)


# Tags
- `latest` - the latest recommended build
- `*-alpine` - minimal images built from `alpine:latest`
- `*-debian` - images built from `debian:stable-slim`
- `old-*` - images build from commit `c77e9fb`


# Environment Variables
> **Note:** actions `docker` and `hostinfo` aren't supported in containers.
Some options from current documentation will be missing from older builds

Not setting any variables will result in
`./sys_monitor_agent <your-docker-ip> 9999 30 --actions= --sysroot --apikey= --securekey=`

|Variable|Default value|Usage|
|-|-|-|
|IP|Your Docker IP address|multicast group \| UDP IP|
|PORT|"9999"|port|
|TIMEOUT|"30"|default_timeout_sec|
|ACTIONS|None|cpu:N,disk:N[<mount1;mount2;..>],df:N[<mount1;..>],ps:N,python:N,iftop:N,hostinfo:N,docker:N,kill_mem:N[<percentage>]|
|SYSROOT|None|root mountpoint|
|API_KEY|None|API key|
|SECURE_KEY|None|crypto key|
|MODE|None|-d \| -p|


# Usage
## docker-compose
Copy the next sample into your docker-compose.yml:
```yaml
services:
  sys_monitor_agent:
    image: daniylx/sys_monitor_agent:latest
    container_name: sys_monitor_agent
    environment:
      - ACTIONS=tcp:10,disk:10[/],ps:10,df:10[/],net:10,memory:10,python:10,cpu:10,iftop:10
      - MODE=-p
    restart: unless-stopped
```

Run the next command to start the container:
```sh
docker compose up -d
```

## docker-cli
> **Warning:** this option will stop and remove container on error

To run the container in the foreground, the next command can be used:
```sh
docker run --rm -it --name sys_monitor_agent -e MODE=-p 
    -e ACTIONS=tcp:10,disk:10[/],ps:10,df:10[/],net:10,memory:10,python:10,cpu:10,iftop:10 \
    daniylx/sys_monitor_agent:latest
```
The container will be stopped and removed on `Ctrl+C`.

