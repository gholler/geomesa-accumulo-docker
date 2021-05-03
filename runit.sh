IMAGE=geomesa-accumulo-minicluster
VERSION=3.0.1-1.9.2
CONTAINER=$IMAGE
docker stop $CONTAINER 2>&1 > /dev/null
docker rm $CONTAINER 2>&1 > /dev/null

# expecting preexiting hadoop and zookeeper containers with these exact names
docker run -d --name $CONTAINER -p 9995:9995 -p 9997:9997 -p 9999:9999 \
	--link hadoop:hadoop \
	--link zookeeper:zookeeper \
	$IMAGE:$VERSION
