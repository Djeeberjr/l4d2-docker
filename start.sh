#!/bin/bash

set -e

/home/steam/steamcmd/steamcmd.sh  +login anonymous +force_install_dir "$HOME/server" +app_update 222860 validate +quit

echo -n "$MOTD_FILE_CONTENT" > "$HOME/server/left4dead2/motd.txt"

echo -n "$HOST_FILE_CONTENT" > "$HOME/server/left4dead2/host.txt"

env | awk -F "=" '/^CVAR_/ {sub("CVAR_","",$1); print tolower($1),($2 ~ /^[0-9]+$/)?$2:"\""$2"\""}' > /home/steam/server/left4dead2/cfg/server.cfg

cat /home/steam/server/left4dead2/cfg/server.cfg

"$HOME/server/srcds_run" -console -game left4dead2 +maxplayers 16 -maxclients 16 -ip 0.0.0.0
