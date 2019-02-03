#
# Scala, sbt and sphinx Dockerfile based on  https://github.com/hseeberger/scala-sbt
#

# Pull base image. We start from Ubuntu because it has docker.io available by default.
FROM ubuntu:18.04

# Env variables
ENV SCALA_VERSION 2.12.8
ENV SBT_VERSION 1.2.8

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo "export PATH=~/scala-$SCALA_VERSION/bin:$PATH" >> /root/.bashrc

# Install sbt and sphinx
RUN \
  apt-get update && \
  apt-get -y install openjdk-11-jdk-headless && \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get -y install docker.io python3-pip && \
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
