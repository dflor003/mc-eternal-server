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

ENV G1NewSizePercent=30 \
    G1MaxNewSizePercent=40 \
    G1HeapRegionSize=8M \
    G1ReservePercent=20 \
    InitiatingHeapOccupancyPercent=15 \
    JAVA_OPTS="-Xmx8g -Xms2G -Xmn128M -XX:PermSize=256m -Dfml.read.Timeout=560 -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=${G1NewSizePercent} -XX:G1MaxNewSizePercent=${G1MaxNewSizePercent} -XX:G1HeapRegionSize=${G1HeapRegionSize} -XX:G1ReservePercent=${G1ReservePercent} -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=${InitiatingHeapOccupancyPercent} -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1"
CMD ["java", "-jar", "/opt/server/forge-1.12.2-14.23.5.2847-universal.jar", "nogui"]
