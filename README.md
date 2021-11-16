Left 4 dead 2 server. With Metamod and Sourcemod.

# Ports
- 27015
- 27015/udp

# Volumes 

You can create a volume at `/home/steam/server` to not redownload the game every time you make a change at the docker-compose file.

# Configuration

You can set ANY conVar you want simply by prefixing the enviroment with `CVAR_`.
So for example to set the RCON password set the enviroment variable `CVAR_RCON_PASSWORD=password123`. 
Try to avoid variables with the word `CVAR_` and avoid `=` in it.

A list of available cvars can be found [here](https://developer.valvesoftware.com/wiki/List_of_L4D2_Cvars).

If there is a new version of Metamod or Sourcemod and is not yet set in the image you can manually set the download URL in `METAMOD_DL_URL` and `SOURCEMOD_DL_URL`.
It will only get update if the addon directory is empty.
