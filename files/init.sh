#!/usr/bin/env bash

if [ "${UPDATE_ON_START}" == "1" ];
then
  echo "Updating Factorio server..." && \
  update_factorio.py --apply-to /opt/factorio/bin/x64/factorio
fi

if [ ! -d "/opt/factorio/saves" ];
then
  mkdir /opt/factorio/saves
fi

COOKIE_ENC_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
sed -i s/COOKIE_ENTRYPTION_KEY/${COOKIE_ENC_KEY}/g /opt/factorio-server-manager/conf.json

(cd /opt/factorio-server-manager && ./factorio-server-manager -dir /opt/factorio)

