FROM debian:buster

ARG FACTORIO_VERSION=0.17.67

RUN apt-get update && \
  apt-get install -y python-pip wget && \
  pip install requests && \
  wget https://raw.githubusercontent.com/narc0tiq/factorio-updater/master/update_factorio.py -O /tmp/update_factorio.py && \
  wget https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -O /tmp/factorio_headless.tar.xz && \
  mkdir /opt/factorio && \
  tar -C /opt/factorio --strip 1 -xf /tmp/factorio_headless.tar.xz && \
  echo "Updating Factorio server..." && \
  python /tmp/update_factorio.py --apply-to /opt/factorio/bin/x64/factorio
