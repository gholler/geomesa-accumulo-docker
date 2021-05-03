#! /usr/bin/env bash

source /sbin/accumulo-lib.sh


register_runtime()
{
	start_accumulo 
	/sbin/register_geomesa_runtime.sh
	stop_accumulo
}

set -x

check_geomesa()
{
    hdfs dfs -ls /accumulo/classpath/geomesa 2>&1 > /dev/null
}

check_geomesa
if [ $? -ne 0 ]
then
	echo "registering geomesa runtime"
	register_runtime || fail "failed"
	echo "done"
fi

exec  "$@"

