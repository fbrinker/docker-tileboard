# TileBoard Docker-Container

[![Build Status](https://drone-github.f-brinker.de/api/badges/fbrinker/docker-tileboard/status.svg)](https://drone-github.f-brinker.de/fbrinker/docker-tileboard)
[![Docker Pulls](https://badgen.net/docker/pulls/fbrinker/tileboard?icon=docker&label=pulls)](https://hub.docker.com/r/fbrinker/tileboard)

This is a very basic Docker container for [TileBoard](https://github.com/resoai/TileBoard), "a simple yet highly configurable Dashboard for HomeAssistant".

It contains the sources and starts a simple Python3 webserver to serve TileBoard at port 8000.

### Contribute

You can open any new issues [here](https://github.com/fbrinker/docker-tileboard/issues).
**The builds are automated** on changes of the official TileBoard repository.

Have a look at the [Dockerfile](https://github.com/fbrinker/docker-tileboard).

## Usage

You have to mount your `config.js` file into the `/tileboard` directory of the Docker container. You can see an [example config.js file in the official repository](https://github.com/resoai/TileBoard/blob/master/config.example.js).

## Versions / Tags

Besides the latest version, you can listen to updates for a specific version:
  * `fbrinker/tileboard` *(same as :latest)*
  * `fbrinker/tileboard:latest`
  * `fbrinker/tileboard:2`
  * `fbrinker/tileboard:2.2`
  * `fbrinker/tileboard:2.2.0`

### Nightly/Dev-Builds

Additionally, there are `nightly` and `dev` builds as follows:
  * `fbrinker/tileboard:nightly` contains a nightly build of TileBoard's `master` branch. Use it to have the most bleeding edge changes, which have not made it into a release yet.
  * `fbrinker/tileboard:dev` bundles TileBoard's source code and runs `yarn run dev` inside the container. Use it to modify the source, check your changes into GitHub and propose a pull request to TileBoard. See the TileBoard [contribution page](https://github.com/resoai/TileBoard/blob/master/CONTRIBUTING.md) for details.


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

## Extended Example

I am using it in my docker-compose file like this, with my config.js, secrets and other customizations:

```yaml
# Home Assistant TileBoard
tileboard:
  container_name: tileboard
  image: fbrinker/tileboard
  hostname: tileboard
  volumes:
    - ./tileboard/config/config.js:/tileboard/config.js
    - ./tileboard/config/secrets.js:/tileboard/includes/config/secrets.js
    - ./tileboard/config/pages:/tileboard/includes/pages
    - ./tileboard/styles/background.png:/tileboard/images/background.png
    - ./tileboard/styles/custom.css:/tileboard/styles/custom.css
  ports:
    - "8234:8000"
  restart: unless-stopped
  depends_on:
    - homeassistant
```

Note: You should never expose TileBoard to the web.