FROM debian:buster

# Version of Factorio server to build with
ARG FACTORIO_VERSION=0.17.69

# If set, update the server on start
ENV UPDATE_ON_START=1

# For persistent config and saves
ENV FACTORIO_USERDATA=/opt/factorio/userdata

RUN apt-get update && \
  apt-get install -y python-pip wget && \
  pip install requests && \
  wget https://raw.githubusercontent.com/narc0tiq/factorio-updater/master/update_factorio.py -O /usr/local/bin/update_factorio.py && \
  chmod +x /usr/local/bin/update_factorio.py && \
  wget https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -O /tmp/factorio_headless.tar.xz && \
  mkdir /opt/factorio && \
  tar -C /opt/factorio --strip 1 -xf /tmp/factorio_headless.tar.xz && \
  echo "config-path=__PATH__executable__/../../userdata/config\nuse-system-read-write-data-directories=false" > /opt/factorio/config-path.cfg

ADD files/ /

VOLUME $FACTORIO_USERDATA

EXPOSE 34197/udp

ENTRYPOINT /init.sh
