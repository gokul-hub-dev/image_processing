cmake_minimum_required(VERSION 3.10)
project(Testing)

# Set the paths to OpenCV
set(OpenCV_DIR /usr/lib/aarch64-linux-gnu/cmake/opencv4)

# Find OpenCV
find_package(OpenCV REQUIRED)

# Include OpenCV headers
include_directories(${OpenCV_INCLUDE_DIRS})

# Add executable
add_executable(testing testing.cpp)

# Link OpenCV libraries
target_link_libraries(testing ${OpenCV_LIBS})

