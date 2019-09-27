#!/usr/bin/env bash

if [ "${UPDATE_ON_START}" == "1" ];
then
  echo "Updating Factorio server..." && \
  update_factorio.py --apply-to /opt/factorio/bin/x64/factorio
fi

SAVE_FILE="${FACTORIO_USERDATA}/saves/game.zip"

if [ ! -f "${SAVE_FILE}" ];
then
  echo "${SAVE_FILE} doesn't exist. Creating a new save..."
  /opt/factorio/bin/x64/factorio --create ${SAVE_FILE}
fi

/opt/factorio/bin/x64/factorio --start-server ${SAVE_FILE}
