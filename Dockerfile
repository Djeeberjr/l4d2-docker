FROM cm2network/steamcmd:latest

COPY start.sh /home/steam/start.sh

WORKDIR /home/steam/

ENTRYPOINT /home/steam/start.sh
