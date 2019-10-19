FROM python:alpine

MAINTAINER Florian Brinker "mail+docker@f-brinker.de"

# Install Git
RUN apk update && \
    apk add --no-cache bash git

# Clone Tileboard
RUN git clone https://github.com/resoai/TileBoard.git /tileboard

# Start Server
WORKDIR /tileboard
EXPOSE  8000
ENTRYPOINT python3 -m http.server
