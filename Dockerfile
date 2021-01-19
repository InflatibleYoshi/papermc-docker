# JRE base
FROM arm64v8/openjdk:11.0-jre-slim

# Environment variables
ENV MC_VERSION="1.16.3" \
    PAPER_BUILD="latest" \
    MC_RAM="6G" \
    JAVA_OPTS="-XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=50 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:InitiatingHeapOccupancyPercent=20	-XX:G1MixedGCLiveThresholdPercent=50 -XX:+AggressiveOpts"

ADD papermc.sh .
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get install -y jq \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /papermc

# Start script
CMD ["sh", "./papermc.sh"]

# Container setup
EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc
