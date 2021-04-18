#!/bin/bash

set -e

echo "### Installing / Updateing l4d2 ###"

/home/steam/steamcmd/steamcmd.sh  +login anonymous +force_install_dir $HOME/server +app_update 222860 validate +quit

echo "### Creating config ###"

cd $HOME/server
cp $HOME/server.cfg $HOME/server/left4dead2/cfg/server.cfg

env | awk -F "=" '/^CVAR_/ {sub("CVAR_","",$1); print tolower($1),($2 ~ /^[0-9]+$/)?$2:"\""$2"\""}' > docker_server.cfg

echo "### Using follwing config: "
cat $HOME/server/left4dead2/cfg/server.cfg
echo "###"

echo "### Linking host and motd file ### "

if [[ -f "/motd.txt" ]]; then
    rm $HOME/server/left4dead2/motd.txt
    ln -sf /motd.txt $HOME/server/left4dead2/motd.txt
fi

if [[ -f "/host.txt" ]]; then
    rm $HOME/server/left4dead2/host.txt
    ln -sf /host.txt $HOME/server/left4dead2/host.txt
fi

echo "### Starting l4d2 ###"

$HOME/server/srcds_run -console -game left4dead2 +maxplayers 16 -maxclients 16 -ip 0.0.0.0 +map c1m1_hotel +exec docker_server.cfg
