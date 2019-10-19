# TileBoard Docker-Container

[![Build Status](https://cd.f-brinker.de/api/badges/fbrinker/docker-tileboard/status.svg)](https://cd.f-brinker.de/fbrinker/docker-tileboard)

This is a very basic Docker container for [TileBoard](https://github.com/resoai/TileBoard), "a simple yet highly configurable Dashboard for HomeAssistant".

It contains the sources and starts a simple Python3 webserver to serve TileBoard at port 8000.

## Usage

You have to mount your `config.js` file into the `/tileboard` directory of the Docker container.

## Example

Here is an example, using Docker-Compose:

```yaml
version: '3'
services:

  tileboard:
    image: fbrinker/tileboard
    volumes:
      - ./config.js:/tileboard/config.js
    ports:
      - "8234:8000"
```

After a `docker-compose up -d`, you can reach your TileBoard instance under `http://[yourhost-or-ip]:8234`.

## Sources

Have a look at the [Git-Repository](https://git.f-brinker.de/fbrinker/docker-tileboard).