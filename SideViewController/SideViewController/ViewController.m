//
//  ViewController.m
//  SideViewController
//
//  Created by YouXianMing on 16/6/6.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"
#import "MainViewController.h"
#import "UIView+SetRect.h"

@interface ViewController () {
    
    CGFloat _screenWidth;
}

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic)         CGPoint                 panBeginPoint;

@property (nonatomic, strong) LeftViewController     *leftViewController;
@property (nonatomic, strong) UIView                 *leftView;

@property (nonatomic, strong) MainViewController     *mainViewController;
@property (nonatomic, strong) UIView                 *mainView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Init some value.
    _screenWidth = Width;
    
    // Add backgroundView.
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image        = [UIImage imageNamed:@"back"];
    [self.view addSubview:backgroundView];
    
    // LeftViewController
    self.leftViewController = [[LeftViewController alloc] init];
    self.leftView           = self.leftViewController.view;
    [self.view addSubview:self.leftView];
    
    // MainViewController
    self.mainViewController = [[MainViewController alloc] init];
    self.mainView           = self.mainViewController.view;
    [self.view addSubview:self.mainView];
    
    // Pan gesture.
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureEvent:)];
    [self.mainView addGestureRecognizer:self.panGesture];
}

- (void)panGestureEvent:(UIPanGestureRecognizer *)gesture {
    
    CGPoint translation = [gesture translationInView:gesture.view];
    CGPoint velocity    = [gesture velocityInView:gesture.view];
    
    CGFloat gap               = _screenWidth / 3.f * 2;
    CGFloat sensitivePosition = _screenWidth / 2.f;
    
    if (velocity.x < 0 && _mainView.x <= 0) {
        
        // 过滤掉向左侧滑过头的情形
        _mainView.x = 0.f;
        
    } else {
        
        if (gesture.state == UIGestureRecognizerStateBegan) {
            
            // 开始
            _panBeginPoint = translation;
            
            if (_mainView.x >= sensitivePosition) {
                
                _panBeginPoint.x -= gap;
            }
            
        } else if (gesture.state == UIGestureRecognizerStateChanged) {
            
            // 值变化
            _mainView.x = translation.x - _panBeginPoint.x;
            
            if (_mainView.x <= 0) {
                
                // 过滤掉向左侧滑过头的情形
                _mainView.x = 0.f;
            }
            
        } else if (gesture.state == UIGestureRecognizerStateEnded) {
            
            // 结束
            [UIView animateWithDuration:0.20f animations:^{
                
                _mainView.x >= sensitivePosition ? (_mainView.x = gap) : (_mainView.x = 0);
            }];
        }
    }
}

@end
