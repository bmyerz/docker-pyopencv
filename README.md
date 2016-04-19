# docker-pyopencv
Builds a docker image for OpenCV 3.1.0 with python bindings.

Find the image at https://hub.docker.com/r/bmyerz/py-opencv/.

# Quick start using the image
You don't need this repository to simply use the docker image.

```bash
docker pull bmyerz/py-opencv
docker run -i -t bmyerz/py-opencv /bin/bash
```
Once in the shell, you can test the installation
```bash
workon cv
python
>>> import cv2
```

# Building the image
You can rebuild the image from the Dockerfile

```bash
git clone git@github.com:bmyerz/docker-pyopencv.git 
cd docker-pyopencv
docker build
```
