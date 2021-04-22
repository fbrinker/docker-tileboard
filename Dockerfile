FROM python:alpine
LABEL maintainer="mail+docker@f-brinker.de"

# Install wget
RUN  apk update \                                                                                                                                                                                                                        
    && apk add ca-certificates wget unzip \                                                                                                                                                                                                      
    && update-ca-certificates    

# Download TileBoard
RUN wget -q -O release.zip "%RELEASE_URL%" \
    && unzip release.zip -d /tileboard/ \
    && rm release.zip

# Start Server
WORKDIR /tileboard
EXPOSE  8000
ENTRYPOINT python3 -m http.server