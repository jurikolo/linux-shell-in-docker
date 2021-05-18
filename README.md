# linux-shell-in-docker
This project creates Docker image that can be transferred to another computer and launched.

Primary use-case is to create an image that can be run on a computer that has limited connectivity to outside world, but you need to use tools that are unavailable on that computer.

# How to
Short guide how to create Docker image
* Review `Dockerfile` and define packages you need. Default Dockerfile is based on Fedora and has following packages:
    * [python3](https://www.python.org/)
    * [kubectl](https://github.com/kubernetes/kubectl)
    * [terraform](https://www.terraform.io/)
    * [httpie](https://httpie.io/)

* Create an image
  ```bash
  docker build -t linux-shell:0.0.1 .
  ```

* Save image and compress
  ```bash
  docker save linux-shell:0.0.1 | gzip > linux-shell_0_0_1.tar.gz
  ```

* Transfer image to destination computer

* Load image from archive
  ```bash
  docker load < linux-shell_0_0_1.tar.gz
  ```

* Run the container
  ```bash
  sudo docker run -d --rm linux-shell:0.0.1
  ```

* Connect to the container
  ```bash
  sudo docker exec -it CONTAINER_ID_HERE /bin/bash
  ```

Voila, you are in a fully customizable shell now! 

# Notes
## Container running time
Container running time is limited to 10 hours, then it terminates.
Make sure to persist data somewhere, for example on a mounted volume.