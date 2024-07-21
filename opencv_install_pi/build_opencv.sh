#!/bin/bash

UNINSTALL_OPENCV='no'
DEP_INSTALL='no'
DOWNLOAD_OPENCV='no'
BUILD_INSTALL='yes'
CLEAN_BUILD='yes'

# Uninstall OpenCV
if [ "$UNINSTALL_OPENCV" == "yes" ]; then
	echo "Uninstalling OpenCV..."
	sudo rm -rf /usr/local/include/opencv4
	sudo rm -rf /usr/local/lib/libopencv_*
	sudo rm -rf /usr/local/share/opencv4
	sudo rm -rf /usr/local/bin/opencv_*
	sudo ldconfig
	echo "OpenCV uninstallation completed."
fi

# Clean build files
if [ "$CLEAN_BUILD" == "yes" ]; then
	cd ~/opencv_build/opencv/build
	make clean
	echo "Build files cleaned."
fi

if [ "$DEP_INSTALL" == "yes" ]; then
	# Update and upgrade the system
	sudo apt-get update && sudo apt-get upgrade -y
	# Install dependencies
	sudo apt-get install -y build-essential cmake git pkg-config libgtk-3-dev \
	libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev \
	libx264-dev libjpeg-dev libpng-dev libtiff-dev gfortran openexr \
	libatlas-base-dev python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev
fi

# Download OpenCV and OpenCV Contrib
if [ "$DOWNLOAD_OPENCV" == "yes" ]; then
	mkdir -p ~/opencv_build
	cd ~/opencv_build 
	git clone https://github.com/opencv/opencv.git
	git clone https://github.com/opencv/opencv_contrib.git
fi

# Build and install OpenCV
if [ "$BUILD_INSTALL" == "yes" ]; then
	cd ~/opencv_build/opencv
	mkdir -p build
	cd build

	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	      -D CMAKE_INSTALL_PREFIX=/usr/local \
	      -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
	      -D ENABLE_NEON=ON \
	      -D ENABLE_VFPV3=ON \
	      -D BUILD_TESTS=OFF \
	      -D OPENCV_ENABLE_NONFREE=ON \
	      -D INSTALL_PYTHON_EXAMPLES=OFF \
	      -D BUILD_EXAMPLES=OFF ..
	make -j4
	sudo make install
	sudo ldconfig
	echo "OpenCV installation completed."
fi


