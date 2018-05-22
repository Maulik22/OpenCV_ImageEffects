//
//  ViewController.m
//  OpenCVDemo
//
//  Created by Maulik Bhuptani on 19/04/18.
//  Copyright © 2018 Maulik Bhuptani. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self isThisWorking];
    
    // Load a UIImage from a resource file.
    UIImage *originalImage =
    [UIImage imageNamed:@"nature"];
    
    // Convert the UIImage to a cv::Mat.
    UIImageToMat(originalImage, originalMat);
    
    switch (originalMat.type()) {
            
        case CV_8UC1:
            // The cv::Mat is in grayscale format.
            // Convert it to RGB format.
            cv::cvtColor(originalMat, originalMat,
                         cv::COLOR_GRAY2RGB);
            break;
            
        case CV_8UC4:
            // The cv::Mat is in RGBA format.
            // Convert it to RGB format.
            cv::cvtColor(originalMat, originalMat,
                         cv::COLOR_RGBA2RGB);
#ifdef WITH_OPENCV_CONTRIB
            // Adjust the white balance.
            cv::xphoto::autowbGrayworld(originalMat,
                                        originalMat);
#endif
            break;
            
        case CV_8UC3:
            // The cv::Mat is in RGB format.
#ifdef WITH_OPENCV_CONTRIB
            // Adjust the white balance.
            cv::xphoto::autowbGrayworld(originalMat, originalMat);
#endif
            break;
        default:
            break;
    }
    
    // Call an update method every 2 seconds.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                  target:self selector:@selector(updateImage)
                                                userInfo:nil repeats:YES];
}

- (void)updateImage {
    
    // Generate a random color.
    double r = 0.5 + RAND_0_1() * 1.0;
    double g = 0.6 + RAND_0_1() * 0.8;
    double b = 0.4 + RAND_0_1() * 1.2;
    
    cv::Scalar randomColor(r, g, b);
    
    // Create an updated, tinted cv::Mat by multiplying the
    // original cv::Mat and the random color.
    cv::multiply(originalMat, randomColor, updatedMat);
    
    // Convert the updated cv::Mat to a UIImage and display
    // it in the UIImageView.
    
    self.imageView.image = MatToUIImage(updatedMat);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) isThisWorking {
    cout << "Works as expected!" << endl;
}

@end
