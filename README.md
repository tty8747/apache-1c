# apache-1c

## Check 1c version inside docker image
`docker run --rm --name test test:v2 /opt/1C/v8.3/x86_64/rac -v`

## Publish base
`docker run --rm --name test test:v2 /opt/1C/v8.3/x86_64/webinst -publish -apache24 -wsdir InfoBase -dir /var/www/infobase -connstr "Srvr=SRV-1C;Ref=Infobase;" -confpath /etc/apache2/apache2.conf`

- `publish` it action publish
- `apache24` version your apache. If use to Apache 2.2 then should indicate apache22
- `wsdir` publication name, ex. http://1.1.1.1/this_name. It's case-sensitive
- `dir` path for publication
- `connstr` connection string, consists of several parts: Srvr - server name, Ref - base name on server, each part must end with symblol ';'
- `confpath` path to config file of your web-server

## Run docker image
`docker run --name test -p 8080:80 -d test:v2`
