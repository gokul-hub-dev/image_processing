#include <stdio.h>
#include <opencv2/opencv.hpp>

int main(int argc, char** argv) {
    if (argc != 2) {
        std::cout << "Usage: ./display_image <image_path>" << std::endl;
        return -1;
    }

    cv::Mat image = cv::imread(argv[1], cv::IMREAD_COLOR);
    if (image.empty()) {
        std::cout << "Could not open or find the image" << std::endl;
        return -1;
    }

    cv::namedWindow("Display Image", cv::WINDOW_AUTOSIZE);
    cv::imshow("Display Image", image);

    cv::waitKey(0);
    return 0;
}

