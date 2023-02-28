# ------------ ベースとなるイメージファイル
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# ------------ 環境設定
ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs
ENV DISPLAY host.docker.internal:0.0
ENV DEBIAN_FRONTEND=noninteractive

# ------------ タイムゾーンの設定
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo 

# ------------ Add User setting
## ARG USERNAME=pi
## ARG GROUPNAME=pi
## ARG UID=999
## ARG GID=999
## RUN groupadd -g $GID $GROUPNAME && \
##     useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

# ------------ ワークディレクトリの設定
## USER $USERNAME
## WORKDIR /home/$USERNAME/

# ------------ Ubuntu上での環境構築
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip && \
    apt-get install wget -y

## # windows上でx-serverに接続するために必要なx11-appsのインストール
## RUN apt-get install x11-apps -y

# gitのインストール（20.04以降はデフォルトでインストールされていない）
RUN apt-get install git -y
 
# matplotlibなどでの描画GUIに必要
RUN apt-get install python3-tk -y
 
# PyTorchのためのライブラリをインストール
RUN python3 -m pip install torch torchvision

## # Opencv install. latest branch is 4.7.0 now.
## RUN apt-get update && \
##     apt-get install cmake g++ git && \
##     git clone -b 4.7.0 https://github.com/opencv/opencv.git /opt/opencv_4.7.0 && \
##     cd /opt/opencv_4.7.0 && \
##     mkdir -p build && cd build && \
##     cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_GENERATE_PKGCONFIG=ON -DWITH_V4L=ON -D WITH_FFMPEG=ON -D OPENCV_FFMPEG_USE_FIND_PACKAGE=ON -D BUILD_TESTS=ON -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_calib3d=ON -D BUILD_opencv_dnn=OFF -D BUILD_opencv_features2d=ON -D BUILD_opencv_flann=ON -D BUILD_opencv_gapi=OFF -D BUILD_opencv_ml=ON -D BUILD_opencv_objdetect=ON -D BUILD_opencv_photo=ON -D BUILD_opencv_stitching=ON -D BUILD_opencv_video=ON -DCMAKE_INSTALL_PREFIX=/usr/local -D FORCE_VTK=ON -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_CUBLAS=ON -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES" -D WITH_GDAL=ON -D WITH_XINE=ON -D BUILD_EXAMPLES=ON .. && \
##     make -j8 && \
##     make install

# ------------ ROS2のセットアップ
# COPY setup.sh /opt
# RUN bash /opt/setup.sh
