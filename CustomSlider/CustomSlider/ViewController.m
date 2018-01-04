//
//  ViewController.m
//  CustomSlider
//
//  Created by YouXianMing on 2018/1/3.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 120.f, 50.f)];
    slider.center    = self.view.center;
    
    // TrackImage都需要做图片的resizable，否则会变形
    
    [slider setMinimumTrackImage:[[UIImage imageNamed:@"currentMinimumTrackImage"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)]
                        forState:UIControlStateNormal];
    
    [slider setMaximumTrackImage:[[UIImage imageNamed:@"currentMaximumTrackImage"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6)]
                        forState:UIControlStateNormal];
    
    [slider setThumbImage:[UIImage imageNamed:@"currentThumbImage"]
                 forState:UIControlStateNormal];

    [self.view addSubview:slider];
    
    slider.layer.borderWidth = 0.5f;
    slider.layer.borderColor = [UIColor redColor].CGColor;
}

@end
