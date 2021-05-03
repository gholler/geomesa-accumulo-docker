FROM cybermaggedon/accumulo:1.9.3a

ARG SCALA_VERSION=2.11
ARG GEOMESA_VERSION=3.0.1

ADD "https://github.com/locationtech/geomesa/releases/download/geomesa_$SCALA_VERSION-$GEOMESA_VERSION/geomesa-accumulo_$SCALA_VERSION-$GEOMESA_VERSION-bin.tar.gz" /usr/local

RUN cd /usr/local && tar xvf geomesa-accumulo_$SCALA_VERSION-$GEOMESA_VERSION-bin.tar.gz && rm /usr/local/geomesa-accumulo_$SCALA_VERSION-$GEOMESA_VERSION-bin.tar.gz

RUN ln -s /usr/local/geomesa-accumulo_$SCALA_VERSION-$GEOMESA_VERSION /usr/local/geomesa

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-1.fc32.x86_64/jre
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/zookeeper/bin

# RUN cp /opt/geomesa-accumulo_$SCALA_VERSION-$GEOMESA_VERSION/dist/accumulo/geomesa-accumulo-distributed-runtime_$SCALA_VERSION-$GEOMESA_VERSION.jar $ACCUMULO_HOME/lib/ext

ADD "https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.5/commons-configuration2-2.5.jar" /usr/local/geomesa/lib
ADD "https://repo1.maven.org/maven2/org/apache/commons/commons-text/1.6/commons-text-1.6.jar" /usr/local/geomesa/lib
ADD "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/2.8.5/hadoop-auth-2.8.5.jar" /usr/local/geomesa/lib
ADD "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/2.8.5/hadoop-common-2.8.5.jar" /usr/local/geomesa/lib
ADD "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs/2.8.5/hadoop-hdfs-2.8.5.jar" /usr/local/geomesa/lib
ADD "https://repo1.maven.org/maven2/org/apache/htrace/htrace-core4/4.1.0-incubating/htrace-core4-4.1.0-incubating.jar" /usr/local/geomesa/lib
ADD "https://repo1.maven.org/maven2/org/apache/zookeeper/zookeeper/3.4.14/zookeeper-3.4.14.jar" /usr/local/geomesa/lib

COPY client.conf $ACCUMULO_HOME/conf

COPY *.sh /sbin/
RUN chmod u+x /sbin/docker-entrypoint.sh /sbin/register_geomesa_runtime.sh

ENV GEOMESA_HOME=/usr/local/geomesa-accumulo_$SCALA_VERSION-$GEOMESA_VERSION
ENV PATH=$PATH:$GEOMESA_HOME/bin

ENTRYPOINT ["/sbin/docker-entrypoint.sh"]

CMD ["/start-accumulo"]
