//
//  ViewController.m
//  StatusBarAnimation
//
//  Created by YouXianMing on 16/6/28.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "StatusBarValue.h"
#import "GCD.h"

@interface ViewController ()

@property (nonatomic, strong) StatusBarValue  *statusBarValue;
@property (nonatomic, strong) GCDTimer        *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.statusBarValue = [StatusBarValue statusBarValueWithController:self];
    
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        // Set hidden or not.
        self.statusBarValue.hidden = NO;
        
        // Set animation type.
        self.statusBarValue.animationType = UIStatusBarAnimationSlide;
        
        // Set bar style type.
        self.statusBarValue.style == UIStatusBarStyleDefault ?
        (self.statusBarValue.style = UIStatusBarStyleLightContent) :
        (self.statusBarValue.style = UIStatusBarStyleDefault);
        
        // Start change.
        [self.statusBarValue statusBarAppearanceUpdateAnimated:YES duration:0.35f];
        
    } timeIntervalWithSecs:1.f delaySecs:1.f];
    [self.timer start];
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return _statusBarValue.style;
}

- (BOOL)prefersStatusBarHidden {

    return _statusBarValue.hidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {

    return _statusBarValue.animationType;
}

@end
