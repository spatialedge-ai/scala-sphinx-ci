#
# Scala, sbt and sphinx Dockerfile based on  https://github.com/hseeberger/scala-sbt
#

# Pull base image. We start from Ubuntu because it has docker.io available by default.
FROM ubuntu:18.04

# Env variables
ENV SCALA_VERSION 2.12.10
ENV SBT_VERSION 1.3.2
ENV JAVA_VERSION 8

RUN \
  apt-get update && \
  apt-get -y install openjdk-${JAVA_VERSION}-jdk-headless curl docker.io python3-pip && \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc && \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  pip3 install sphinx sphinx_rtd_theme sphinx-autobuild sphinx_tabs sphinxcontrib-httpdomain && \
  sbt sbtVersion && \
  mkdir project && \
  echo "scalaVersion := \"${SCALA_VERSION}\"" > build.sbt && \
  echo "sbt.version=${SBT_VERSION}" > project/build.properties && \
  echo "case object Temp" > Temp.scala && \
  sbt compile && \
  rm -r project && rm build.sbt && rm Temp.scala && rm -r target && \
  apt-get clean

# Define working directory
WORKDIR /root
