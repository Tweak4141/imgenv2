# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: python3
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        python:3.9-slim

LABEL       author="Tweak4141" maintainer="tweak@daftscientist.com"
RUN         echo "deb [trusted=yes] http://httpredir.debian.org/debian jessie main contrib" > /etc/apt/sources.list \
            && echo "deb [trusted=yes] http://security.debian.org/ jessie/updates main contrib" >> /etc/apt/sources.list \
            && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
            && apt update \
            && apt install -y ttf-mscorefonts-installer \
            && apt clean \
            && apt autoremove -y \
            && rm -rf /var/lib/apt/lists/* \
            && apt -y install git gcc g++ ca-certificates fonts-symbola ghostscript fonts-dejavu-core dnsutils curl iproute2 ffmpeg procps apt-utils imagemagick libmagickwand-dev python3-pythonmagick --no-install-recommends \
            && sed -i '/<policy domain="path" rights="none" pattern="@\*"/d' /etc/ImageMagick-6/policy.xml \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
