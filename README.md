Docker container with mariadb and syslog forwarding
Based on Alpine with around 172MB

NOTE: Example assumes you have a "/mysql" with your container specific data!
Change as needed with the SRC data that you are mounting into the container.
Example named data is defined in the example subdir.

## Required "DATA" directory:
This container assumes you have a "/mysql" folder with your container specific data:
You can change that folder as needed, but make sure you update the "-v" mounts for run time

1.) [ *REQUIRED* ] In your /mysql/etc/mysql a file "smb.conf", which acts as an entry point to your config

2.) [ *REQUIRED* ] A "/mysql/var/lib/mysql" directory for the Mariadb database

3.) [ *OPTIONAL* ] set environment variable "UDPLOGHOST" or "TCPLOGHOST", if defined rsyslog will be started with remote SYSLOG logging to these hosts. If you use remote syslog, then it might be useful to set the hostname of the container depending on your server syslog configuration (the logs on the syslog server might get stored based on the hostname of the client)


## Run mysql

```
docker run --name=mariadbserver --hostname=mariadbserver --rm -p 137:137/udp -p 138:138/udp -p 139:139 -p 445:445 -e UDPLOGHOST=192.168.0.17  -v /mysql/var/lib/mysql:/var/lib/mysql  -v /mysql/etc/mysql:/etc/mysql qindel/mariadb-syslog
```