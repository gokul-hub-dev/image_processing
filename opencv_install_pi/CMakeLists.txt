cmake_minimum_required(VERSION 3.1)
project(DisplayImage)

# Find OpenCV
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

# Add executable
add_executable(display_image display_image.cpp)

# Link OpenCV libraries
target_link_libraries(display_image ${OpenCV_LIBS})

