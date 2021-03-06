#
# Resin.io image for a PyBitmessage node on a Parallella
#

FROM armhfbuild/debian:jessie

MAINTAINER Gergely Imreh <imrehg@mail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    python=2.7.9-1 \
    openssl \
    curl \
    # Remove package lists to free up space
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app && \
    curl -sSL https://github.com/Bitmessage/PyBitmessage/archive/master.tar.gz | tar -C /app -xz && \
    mv /app/PyBitmessage-* /app/PyBitmessage

ADD configs/PyBitmessage/keys.dat /app/PyBitmessage/src/
ADD start.sh /app/PyBitmessage/src/

# PyBitmessage port
EXPOSE 8444
# PyBitmessage API port
EXPOSE 8844

# Uncomment this to send all log to the console
#RUN ln -sf /dev/stdout /var/log/pybitmessage.log

WORKDIR /app/PyBitmessage/src

CMD ["bash", "start.sh"]
