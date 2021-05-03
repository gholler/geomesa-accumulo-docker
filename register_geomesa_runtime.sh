#! /usr/bin/env bash

ACCUMULO_USER=${ACCUMULO_USER:-root}
ACCUMULO_PASSWORD=${ACCUMULO_PASSWORD:-accumulo}

source /sbin/accumulo-lib.sh

set -x

wait_until_accumulo_available ${ACCUMULO_USER} ${ACCUMULO_PASSWORD} || fail "Aborting"

hdfs dfs -mkdir -p /accumulo/classpath/geomesa
hdfs dfs -put ${GEOMESA_HOME}/dist/accumulo/*.jar /accumulo/classpath/geomesa 

# fail fast
set -euo pipefail
accumulo shell -u ${ACCUMULO_USER} -p ${ACCUMULO_PASSWORD} -e \
  "createnamespace geomesa"
accumulo shell -u ${ACCUMULO_USER} -p ${ACCUMULO_PASSWORD} -e \
  "config -s general.vfs.context.classpath.geomesa=hdfs://hadoop:9000/accumulo/classpath/geomesa/[^.].*.jar"
accumulo shell -u ${ACCUMULO_USER} -p ${ACCUMULO_PASSWORD} -e \
  "config -ns geomesa -s table.classpath.context=geomesa"
echo "Accumulo namespace configured: geomesa"
