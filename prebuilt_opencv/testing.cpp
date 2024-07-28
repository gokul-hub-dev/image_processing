#include <opencv2/opencv.hpp>
#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>

using namespace std;

int main(int argc, char** argv)
{
    // Check if image path is provided as an argument
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <image_path>" << std::endl;
        return 1;
    }

    // Read the image from the provided path
    cv::Mat img = cv::imread(argv[1], cv::IMREAD_COLOR);

    if (img.empty())
    {
        std::cerr << "Could not read the image from " << argv[1] << std::endl;
        return 1;
    }

    // Resize image for display (if desired)
    cv::resize(img, img, cv::Size(), 0.20, 0.20);

    // Get a named window
    cv::namedWindow("Display Image");

    // Show the color image
    cv::imshow("Display Image", img);

    int k = cv::waitKey(0); // Wait for a keystroke in the window
    return 0;
}

