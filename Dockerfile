FROM ubuntu:trusty

MAINTAINER Wurstmeister

ENV KAFKA_VERSION="0.8.3-SNAPSHOT" SCALA_VERSION="2.10"

RUN apt-get update && apt-get install -y unzip openjdk-6-jdk wget curl git docker.io

ADD kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz /opt
RUN mv /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka

VOLUME ["/kafka"]

ENV KAFKA_HOME /opt/kafka

# hardcoded value for reserved.broker.max.id is 1000
#external port is used as broker.id
RUN echo "reserved.broker.max.id=65000" >> /opt/kafka/config/server.properties

ADD start-kafka.sh /usr/bin/start-kafka.sh
ADD broker-list.sh /usr/bin/broker-list.sh
CMD start-kafka.sh
