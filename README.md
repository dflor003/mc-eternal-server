# MC Eternal Server

Dockerized MineCraft Eternal server.

## Prerequisites

1. Make sure you have [Docker](https://www.docker.com/products/docker-desktop) installed and running.
1. Make sure you have at least 4GB of RAM free and available to allocate to Docker in addition to RAM your system needs for normal operation.

## Setup


If you have a world already, just dump the contents of the world folder into the `/world` directory.

To run the server, just run the following:

```bash
$ docker-compose up -d
```

To view the server logs, run:

```bash
$ docker-compose logs -f mc-server
```

If you need to add additional mods, just add them to the `mod-extra` folder and they will get copied over when the docker image is built.
