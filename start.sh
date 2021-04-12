#!/bin/bash

set -e

echo "### Installing / Updateing l4d2 ###"

/home/steam/steamcmd/steamcmd.sh  +login anonymous +force_install_dir $HOME/server +app_update 222860 validate +quit

echo "### Creating config ###"

cd $HOME/server

env | awk -F "=" '/^CVAR_/ {sub("CVAR_","",$1); print tolower($1),($2 ~ /^[0-9]+$/)?$2:"\""$2"\""}' > docker_server.cfg

echo "### Starting l4d2 ###"

$HOME/server/srcds_run -console -game left4dead2 +maxplayers 16 -maxclients 16 -ip 0.0.0.0 +map c1m1_hotel +exec docker_server.cfg
