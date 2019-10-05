#!/usr/bin/env bash

if [ "${UPDATE_ON_START}" == "1" ];
then
  echo "Updating Factorio server..." && \
  update_factorio.py --apply-to /opt/factorio/bin/x64/factorio
fi

(cd /opt/factorio-server-manager && ./factorio-server-manager -dir /opt/factorio)
