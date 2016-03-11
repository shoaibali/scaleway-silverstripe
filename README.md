# SilverStripe image on Scaleway

Scripts to build the official SilverStripe image on Scaleway

This image is built using [Image Tools](https://github.com/scaleway/image-tools) and depends on the official [Ubuntu](https://github.com/scaleway/image-ubuntu) image.


<img src="https://upload.wikimedia.org/wikipedia/commons/3/3f/SilverStripe_logo_create_the_web.png" width="400px" />


---

**This image is meant to be used on a C1 server.**

We use the Docker's building system and convert it at the end to a disk image that will boot on real servers without Docker. Note that the image is still runnable as a Docker container for debug or for inheritance.

[More info](https://github.com/scaleway/image-tools)


---

## How to connect to your C1 server

See the [documentation](https://www.scaleway.com/docs/create-and-connect-to-your-server/) to connect your to your C1 server.

## Install

Build and write the image to /dev/nbd1 (see [documentation](https://www.scaleway.com/docs/create_an_image_with_docker))

    $ make install

Full list of commands available at: [scaleway/image-tools](https://github.com/scaleway/image-tools/#commands)

---
