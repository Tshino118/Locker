#!/bin/bash -e 

# ------------ apt-getリポジトリの追加
apt-get install curl gnupg lsb-release -y
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# ------------ リポジトリをsource listに追加
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# ------------ ワークスペースの作成
apt-get install python3-colcon-common-extensions -y
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/ && colcon build

# ------------ ROS2インストール
sudo apt-get update
sudo apt-get install ros-humble-desktop -y
sudo apt-get install python3-colcon-common-extensions -y

# ------------ V4L2 install
apt-get install v4l-utils -y

# ------------ OpenCV install 
## Aleady installed by Dockerfile.

# sudo apt update && sudo apt install -y cmake g++
# git clone -b 4.7.0 https://github.com/opencv/opencv.git opencv_4.7.0
# cd opencv_4.7.0
# mkdir -p build && cd build
# cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_GENERATE_PKGCONFIG=ON -DWITH_V4L=ON -D WITH_FFMPEG=ON -D OPENCV_FFMPEG_USE_FIND_PACKAGE=ON -D BUILD_TESTS=ON -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_calib3d=ON -D BUILD_opencv_dnn=OFF -D BUILD_opencv_features2d=ON -D BUILD_opencv_flann=ON -D BUILD_opencv_gapi=OFF -D BUILD_opencv_ml=ON -D BUILD_opencv_objdetect=ON -D BUILD_opencv_photo=ON -D BUILD_opencv_stitching=ON -D BUILD_opencv_video=ON -DCMAKE_INSTALL_PREFIX=/usr/local -D FORCE_VTK=ON -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_CUBLAS=ON -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES" -D WITH_GDAL=ON -D WITH_XINE=ON -D BUILD_EXAMPLES=ON ..
# make -j8
# sudo make install
# sudo ldconfig


export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# ------------ 環境設定
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# ------------ Gazeboのインストール
sudo apt-get install gazebo -y
sudo apt-get install ros-humble-gazebo-* -y

# ------------ 環境設定を反映
source ~/.bashrc

