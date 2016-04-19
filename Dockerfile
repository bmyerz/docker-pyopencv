# based on commands from http://www.pyimagesearch.com/2015/06/22/install-opencv-3-0-and-python-2-7-on-ubuntu/
FROM ubuntu:14.04
MAINTAINER Brandon Myers <bmyers1788@gmail.com>

RUN sudo apt-get update && \
    sudo apt-get upgrade && \
    sudo apt-get install -y \
          build-essential \
          cmake \
          git \
          pkg-config \
          libjpeg8-dev \
          libtiff4-dev \
          libjasper-dev \
          libpng12-dev \
          libgtk2.0-dev \
          libavcodec-dev \
          libavformat-dev \
          libswscale-dev \
          libv4l-dev \
          libatlas-base-dev \
          gfortran 

# step 7
RUN sudo apt-get install -y wget vim
RUN cd $HOME && \
     wget https://bootstrap.pypa.io/get-pip.py && \
     sudo python get-pip.py

# step 8
RUN sudo pip install virtualenv virtualenvwrapper
RUN sudo rm -rf $HOME/.cache/pip
RUN echo "# virtualenv and virtualenvwrapper" >> $HOME/.bashrc && \
    echo "export WORKON_HOME=$HOME/.virtualenvs" >> $HOME/.bashrc && \
    echo "source \"/usr/local/bin/virtualenvwrapper.sh\"" >> $HOME/.bashrc

# step 10
RUN cd $HOME && \
             git clone https://github.com/Itseez/opencv.git && \
             cd opencv && \
             git checkout 3.1.0
RUN cd $HOME && \
             git clone https://github.com/Itseez/opencv_contrib.git && \
             cd opencv_contrib && \
             git checkout 3.1.0

# must install opencv/python within virtualenv
# Seems that I do not understand ENV so hardcode /root
ENV WORKON_HOME=/root/.virtualenvs  
#RUN export WORKON_HOME=$HOME/.virtualenvs
RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh && \
    cd $HOME && \
    echo \"inside $WORKON_HOME\" && \
    mkvirtualenv cv && \
    sudo apt-get update && sudo apt-get install -y python2.7-dev && \
    pip install numpy && \
    cd $HOME/opencv && \
                    mkdir build && \
                    cd build && \
                    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON .. && \
             make -j3 && \
             sudo make install && \
             sudo ldconfig && \
    cd $HOME/.virtualenvs/cv/lib/python2.7/site-packages/ && \
    ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so"


WORKDIR $HOME
