FROM cm2network/steamcmd:latest

COPY start.sh /home/steam/start.sh
COPY server.cfg /home/steam/server.cfg

WORKDIR /home/steam/

ENTRYPOINT /home/steam/start.sh
