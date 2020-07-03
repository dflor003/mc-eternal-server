FROM adoptopenjdk:8-jdk-openj9

# Install deps
RUN apt-get update && \
    apt-get -y install unzip

# Install server
ENV MODPACK_URL=https://media.forgecdn.net/files/2981/831/MCEternal(ServerPack1.3.6).zip
RUN mkdir -p /opt/server && \
    cd /opt/server && \
    curl -fsSL ${MODPACK_URL} -o server.zip && \
    unzip server.zip -d . && \
    mv Eternal\ \(ServerPack\ 1.3.6\)/* . && \
    rm -rf Eternal\ \(ServerPack\ 1.3.6\) && \
    ls -al /opt/server

# Copy additional mods over
COPY ./mods-extra/* /opt/server/mods/

# Accept EULA & Copy settings
WORKDIR /opt/server
COPY server.properties /opt/server
RUN echo 'eula=true' > eula.txt

ENV EULA=true JAVA_OPTS='-Xmx6g -Xms256m -Xmn128M -XX:PermSize=256m -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:-UseAdaptiveSizePolicy -Dfml.read.Timeout=560 -Duser.language=en -Duser.country=US'
CMD ["java", "-jar", "/opt/server/forge-1.12.2-14.23.5.2847-universal.jar", "nogui"]
