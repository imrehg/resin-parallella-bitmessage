#
# Resin.io image for a PyBitmessage node on a Parallella
#

FROM armhfbuild/debian:jessie

MAINTAINER Gergely Imreh <imrehg@mail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    python \
    openssl \
    curl \
    # Remove package lists to free up space
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app && \
    curl -sSL https://github.com/Bitmessage/PyBitmessage/tarball/v0.4.4 | tar -C /app -xz && \
    mv /app/Bitmessage-PyBitmessage-* /app/PyBitmessage

ADD . /app/PyBitmessage/src

# PyBitmessage port
EXPOSE 8444
# PyBitmessage API port
EXPOSE 8844

WORKDIR /app/PyBitmessage/src

CMD ["python", "bitmessagemain.py"]
