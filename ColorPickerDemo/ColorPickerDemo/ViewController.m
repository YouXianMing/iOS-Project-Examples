//
//  ViewController.m
//  ColorPickerDemo
//
//  Created by YouXianMing on 2018/11/30.
//  Copyright © 2018 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "ColorPickerImageView.h"

@interface ViewController () <ColorPickerImageViewDelegate>

@property (nonatomic, strong) UIView *showView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // http://www.markj.net/iphone-uiimage-pixel-color/
    
    ColorPickerImageView *imageView = [[ColorPickerImageView alloc] initWithImage:[UIImage imageNamed:@"colorWheel1.png"]];
    imageView.center                = self.view.center;
    imageView.delegate              = self;
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    [self.view addSubview:self.showView];
}

#pragma mark - ColorPickerImageViewDelegate

- (void)colorPickerImageView:(ColorPickerImageView *)imageView color:(UIColor *)color {
    
    self.showView.backgroundColor = color;
}

@end
