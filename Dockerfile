FROM java:8

MAINTAINER Tim Chaubet <tim@chaubet.be>

RUN apt-get install -y wget unzip && \
 addgroup --gid 1234 minecraft && \
 adduser --disabled-password --home=/data --uid 1234 --gid 1234 --gecos "minecraft user" minecraft

VOLUME /data

COPY install.sh /data
COPY start.sh /data

RUN mkdir /tmp/server && cd /tmp/server
RUN wget -c https://media.forgecdn.net/files/3514/613/Above+and+Beyond-1.1-Server.zip -O server.zip
RUN unzip server.zip -d /data
RUN chmod -R 777 /data
RUN chown -R minecraft /data
RUN cd /data && bash -x install.sh
RUN chmod -R 777 /data
RUN chown -R minecraft /data

USER minecraft
WORKDIR /data

EXPOSE 25565

CMD ["/start.sh"]

ENV MOTD "A Minecraft (SkyFactory 4.2.2) Server Powered by Docker"
ENV LEVEL world
ENV JVM_OPTS "-Xms2048m -Xmx2048m"
