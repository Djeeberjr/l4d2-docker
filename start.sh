#!/bin/bash

set -e

/home/steam/steamcmd/steamcmd.sh  +login anonymous +force_install_dir "$HOME/server" +app_update 222860 +quit


if [ ! -e "$HOME/server/left4dead2/addons/metamod.vdf" ]; then
    echo "Installing Metamod"
    curl "$METAMOD_DL_URL" -o /tmp/metamod.tar.gz
    tar -xf /tmp/metamod.tar.gz -C "$HOME/server/left4dead2"
    rm /tmp/metamod.tar.gz

    echo "Install Sourcemod"
    curl "$SOURCEMOD_DL_URL" -o /tmp/sourcemod.tar.gz
    tar -xf /tmp/sourcemod.tar.gz -C "$HOME/server/left4dead2"
    rm /tmp/sourcemod.tar.gz
fi


mkdir -p "$HOME/server/left4dead2/addons/sourcemod/configs/"
echo "// Autogenerated. DO NOT EDIT. Sourcemod admin can be added with the SM_ADMIN environment variable" \
    > "$HOME/server/left4dead2/addons/sourcemod/configs/admins_simple.ini"
for id in $(echo "$SM_ADMIN" | sed 's/,/\n/g')
do
    echo "\"$id\" \"99:z\"" >> "$HOME/server/left4dead2/addons/sourcemod/configs/admins_simple.ini"
done


echo -n "$MOTD_FILE_CONTENT" > "$HOME/server/left4dead2/motd.txt"

echo -n "$HOST_FILE_CONTENT" > "$HOME/server/left4dead2/host.txt"

env | awk -F "=" '/^CVAR_/ {sub("CVAR_","",$1); print tolower($1),($2 ~ /^[0-9]+$/)?$2:"\""$2"\""}' > /home/steam/server/left4dead2/cfg/server.cfg

cat /home/steam/server/left4dead2/cfg/server.cfg

SRCDS_ARGS=""

if [ -n "$INSECURE" ]; then
    SRCDS_ARGS="${SRCDS_ARGS} -insecure"
    echo "Running with VAC disabled."
fi

"$HOME/server/srcds_run" -console -game left4dead2 +maxplayers 16 -maxclients 16 -ip 0.0.0.0 $SRCDS_ARGS
