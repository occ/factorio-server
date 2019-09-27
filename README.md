# factorio-server
Dockerized Factorio server

## Usage

* Create a userdata volume

  `docker volume create factorio_data`

* Start the container

  `docker run --rm -ti -P -v factorio_data:/opt/factorio/userdata onurcc/factorio-server`

## Customizing

* TODO -- Something something mount the volume and add config files into `factorio_data`/config
