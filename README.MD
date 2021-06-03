Dockerfile and resources to build a docker container that can play the role of accumulo master or slave or both, with Geomesa runtime and tools installed on top of it.

It is based on https://github.com/cybermaggedon/accumulo-docker/tree/v1.9.3a and we strongly advice to refer to the README of this project for all aspects relating to accumulo and dependencies
on external zookeepers and hdfs. 


This container will register the geomesa runtime on accumulo the first time it is deployed, in a namespace called geomesa. Likewise, accumulo/geomesa user connection parameters are hard coded:
- user : root
- password : accumulo
- zookeeper host: zookeeper : 2181
- accumulo instance name : accumulo
- hdfs root url: hdfs://hadoop:9000

Note that hadoop and zookeeper host names are hard-coded, use --add-host or --link in the docker run command (see runit.sh for an example).
geomesa-accumulo tool is available on the path, e.g.:

```bash
geomesa-accumulo get-type-names -c geomesa.test -u root -s accumulo
```

As a convenience, hdfs and zookeeper tools are also available:
```
hdfs dfs -ls /accumulo
```


This is mainly useable in a development context, and has been tested ionly in an all-in-one deployment configuration (all accumulo roles in one container), corresponding to the first deployment case of
cybermaggedon README.

