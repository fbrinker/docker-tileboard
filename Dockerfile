FROM python:alpine
LABEL maintainer="mail+docker@f-brinker.de"

# Insert Tileboard
COPY ./files/ /tileboard/

# Start Server
WORKDIR /tileboard
EXPOSE  8000
ENTRYPOINT python3 -m http.server