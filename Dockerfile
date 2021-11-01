FROM cm2network/steamcmd:latest
RUN mkdir -p /home/steam/server
COPY start.sh /home/steam/start.sh
VOLUME "/home/steam/server"
WORKDIR /home/steam/
ENTRYPOINT /home/steam/start.sh
