ARG BASE_IMAGE="nvidia/cuda:11.7.0-devel-ubuntu22.04"

# ------------ Setting baseimage
FROM $BASE_IMAGE
# ------------ Arguments
ARG TIME_ZONE="Asia/Tokyo"

# ------------ Setting enviroment
ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs
ENV DISPLAY host.docker.internal:0.0
ENV DEBIAN_FRONTEND=noninteractive

# ------------ Setting timezone
RUN apt-get update && apt-get install -y tzdata
ENV TZ=$TIME_ZONE 

# ------------ Upgrade apt-get
RUN apt-get update && apt-get upgrade -y

WORKDIR /home

# ------------ Build enviroment in Ubuntu
RUN apt-get install -y python3 python3-pip && \
    apt-get install wget -y

## # windows上でx-serverに接続するために必要なx11-appsのインストール
## RUN apt-get install x11-apps -y

# Install git
RUN apt-get install git -y
 
# Install tk
RUN apt-get install python3-tk -y

# PyTorch for cuda
RUN python3 -m pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 torchaudio==0.13.1 -f https://download.pytorch.org/whl/torch_stable.html 

# Install Opencv. latest branch is 4.7.0 now.
RUN apt-get update && \
    apt-get install -y cmake g++ git ffmpeg libsm6 libxext6 && \
    git clone -b 4.7.0 https://github.com/opencv/opencv.git /opt/opencv_4.7.0 && \
    cd /opt/opencv_4.7.0 && \
    mkdir -p build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_GENERATE_PKGCONFIG=ON -DWITH_V4L=ON -D WITH_FFMPEG=ON -D OPENCV_FFMPEG_USE_FIND_PACKAGE=ON -D BUILD_TESTS=ON -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_calib3d=ON -D BUILD_opencv_dnn=OFF -D BUILD_opencv_features2d=ON -D BUILD_opencv_flann=ON -D BUILD_opencv_gapi=OFF -D BUILD_opencv_ml=ON -D BUILD_opencv_objdetect=ON -D BUILD_opencv_photo=ON -D BUILD_opencv_stitching=ON -D BUILD_opencv_video=ON -DCMAKE_INSTALL_PREFIX=/usr/local -D FORCE_VTK=ON -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_CUBLAS=ON -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES" -D WITH_GDAL=ON -D WITH_XINE=ON -D BUILD_EXAMPLES=ON .. && \
    make -j8 && \
    make install && \
    ldconfig
    

# ------------ Setting ROS2
# COPY ros2_setup.sh /opt
# RUN bash /opt/ros2_setup.sh

# ------------ Setting password to root
ARG ROOT_PASS="root"
RUN echo 'root:root' | chpasswd

# ------------ Add locker user
ARG USER_NAME="locker"
ENV LOCKER_UID=9999
ENV LOCKER_GID=$LOCKER_UID

# Create the user of locker
RUN groupadd --gid $LOCKER_GID ${USER_NAME} \
    && useradd --uid $LOCKER_UID --gid $LOCKER_GID -s /usr/bin/bash -m ${USER_NAME} \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo

# Change password
ARG USER_PASS="locker"
RUN echo "${USER_NAME}":"${USER_PASS}" | chpasswd\
    && usermod -G sudo ${USER_NAME}

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.

# ------------ Add Original User setting
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/bin/bash"]
