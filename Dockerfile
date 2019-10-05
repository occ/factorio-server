FROM debian:buster

# Version of Factorio server to build with
ARG FACTORIO_VERSION=latest

# Factorio Server Manager version
ARG FSM_VERSION=0.8.2

# If set, update the server on start
ENV UPDATE_ON_START=1

# For persistent config and saves
ENV FACTORIO_USERDATA=/opt/factorio/userdata

RUN apt-get update && \
  apt-get install -y musl-dev python-pip unzip wget && \
  # Install factorio-updater
  pip install requests && \
  wget https://raw.githubusercontent.com/narc0tiq/factorio-updater/master/update_factorio.py -O /usr/local/bin/update_factorio.py && \
  chmod +x /usr/local/bin/update_factorio.py && \
  # Install headless factorio server
  wget https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -O /tmp/factorio_headless.tar.xz && \
  mkdir /opt/factorio && \
  tar -C /opt/factorio --strip 1 -xf /tmp/factorio_headless.tar.xz && \
  echo "config-path=__PATH__executable__/../../userdata/config\nuse-system-read-write-data-directories=false" > /opt/factorio/config-path.cfg && \
  # Install Factorio Server Manager
  wget https://github.com/mroote/factorio-server-manager/releases/download/${FSM_VERSION}/factorio-server-manager-linux-${FSM_VERSION}.zip -O /tmp/factorio-server-manager-linux.zip && \
  unzip -d /opt /tmp/factorio-server-manager-linux.zip

ADD files/ /

VOLUME $FACTORIO_USERDATA

EXPOSE 34197/udp
EXPOSE 8080/tcp

ENTRYPOINT /init.sh
