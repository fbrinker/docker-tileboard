# TileBoard Docker-Container

[![Build Status](https://drone.f-brinker.de/api/badges/fbrinker/docker-tileboard/status.svg)](https://drone.f-brinker.de/fbrinker/docker-tileboard)

This is a very basic Docker container for [TileBoard](https://github.com/resoai/TileBoard), "a simple yet highly configurable Dashboard for HomeAssistant".

It contains the sources and starts a simple Python3 webserver to serve TileBoard at port 8000.

### Contribute

You can open any new issues [here](https://git.f-brinker.de/fbrinker/docker-tileboard/issues).
**The builds are automated** on changes of the official TileBoard repository.

Have a look at the [Dockerfile](https://git.f-brinker.de/fbrinker/docker-tileboard).

## Usage

You have to mount your `config.js` file into the `/tileboard` directory of the Docker container. You can see an [example config.js file in the official repository](https://github.com/resoai/TileBoard/blob/master/config.example.js).

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
