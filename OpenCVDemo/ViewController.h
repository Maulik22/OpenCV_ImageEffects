//
//  ViewController.h
//  OpenCVDemo
//
//  Created by Maulik Bhuptani on 19/04/18.
//  Copyright © 2018 Maulik Bhuptani. All rights reserved.
//

#define RAND_0_1() ((double)arc4random() / 0x100000000)

#ifdef __cplusplus

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

using namespace std;

#endif

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    cv::Mat originalMat;
    cv::Mat updatedMat;
}

@property IBOutlet UIImageView *imageView;

@property NSTimer *timer;

- (void)updateImage;

@end

