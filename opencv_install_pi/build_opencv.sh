#!/bin/bash

REMOVE_REPO='no'
UNINSTALL_OPENCV='no'
CLEAN_BUILD='yes'
DEP_INSTALL='no'
DOWNLOAD_OPENCV='no'
BUILD_INSTALL='yes'

# Remove OpenCV repositories
if [ "$REMOVE_REPO" == "yes" ]; then
	echo "Removing OpenCV repositories..."
	rm -rf ~/opencv_build/opencv
	rm -rf ~/opencv_build/opencv_contrib
	echo "OpenCV repositories removed."
fi

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

# Check if DEP_INSTALL is set to "yes"
if [ "$DEP_INSTALL" == "yes" ]; then
    # Print a message indicating the start of system update and upgrade
    echo "Updating and upgrading the system..."

    # Update the list of available packages and their versions
    # Upgrade all installed packages to their latest versions
    sudo apt-get update && sudo apt-get upgrade -y

    # Print a message indicating the start of dependency installation
    echo "Installing required dependencies..."

    # Install essential development tools and libraries needed for building OpenCV
    # - build-essential: Includes compilers and libraries needed for compiling software
    # - cmake: Tool for configuring the build process
    # - git: Version control system for downloading the OpenCV source code
    # - pkg-config: Tool to manage compile and link flags for libraries
    # - libgtk-3-dev: Development files for GTK+ 3, required for GUI support
    # - libavcodec-dev, libavformat-dev, libswscale-dev: Libraries for video and image processing
    # - libv4l-dev: Development files for Video4Linux
    # - libxvidcore-dev, libx264-dev: Libraries for video encoding
    # - libjpeg-dev, libpng-dev, libtiff-dev: Libraries for image format support
    # - gfortran: GNU Fortran compiler
    # - openexr: Libraries for high dynamic range imaging
    # - libatlas-base-dev: Optimized linear algebra library
    # - python3-dev: Development files for Python 3
    # - python3-numpy: NumPy library for Python 3, needed for Python bindings
    # - libtbb2, libtbb-dev: Intel Threading Building Blocks for parallel programming
    # - libdc1394-22-dev: Development files for the DC1394 camera library
    sudo apt-get install -y build-essential cmake git pkg-config libgtk-3-dev \
                            libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                            libxvidcore-dev libx264-dev libjpeg-dev libpng-dev \
                            libtiff-dev gfortran openexr libatlas-base-dev \
                            python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev
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
    # Navigate to the OpenCV source directory
    cd ~/opencv_build/opencv

    # Create a build directory if it doesn't already exist
    mkdir -p build

    # Navigate into the build directory
    cd build

    # Print a message indicating the start of the CMake configuration step
    echo "gokul BUILD_INSTALL : cmake"

    # Run CMake to configure the build system
    # -D CMAKE_BUILD_TYPE=RELEASE: Specifies that we are building the release version
    # -D CMAKE_INSTALL_PREFIX=/usr/local: Sets the installation directory to /usr/local
    # -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules: Includes extra modules from opencv_contrib
    # -D BUILD_TESTS=OFF: Disables the building of test modules
    # -D OPENCV_ENABLE_NONFREE=ON: Enables non-free algorithms in OpenCV (if you need them)
    # -D INSTALL_PYTHON_EXAMPLES=OFF: Disables the installation of Python example scripts
    # -D BUILD_EXAMPLES=OFF: Disables the building of OpenCV example applications
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
          -D BUILD_TESTS=OFF \
          -D OPENCV_ENABLE_NONFREE=ON \
          -D INSTALL_PYTHON_EXAMPLES=OFF \
          -D BUILD_EXAMPLES=OFF ..

    # Print a message indicating the start of the make build process
    echo "gokul BUILD_INSTALL : make"

    # Compile OpenCV using multiple cores to speed up the process (using 4 cores)
    make -j4

    # Print a message indicating the start of the installation process
    echo "gokul BUILD_INSTALL : install"

    # Install the compiled OpenCV binaries and libraries to the specified prefix directory
    sudo make install

    # Update the shared library cache to include the newly installed libraries
    sudo ldconfig

    # Print a message indicating that the OpenCV installation has completed
    echo "OpenCV installation completed."
fi


