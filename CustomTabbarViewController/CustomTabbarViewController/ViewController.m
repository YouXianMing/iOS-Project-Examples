//
//  ViewController.m
//  TabbarController
//
//  Created by XianMingYou on 15/4/15.
//  Copyright (c) 2015年 XianMingYou. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UIButton+DemoUse.h"

typedef enum : NSUInteger {
    
    kFirstViewController = 0x12,
    kSenondViewController,
    kButtonsContentView,
    
} EButtonFlag;

@interface ViewController ()

@property (nonatomic, strong) UIView               *contentView;
@property (nonatomic, strong) FirstViewController  *firstVC;
@property (nonatomic, strong) SecondViewController *secondVC;
@property (nonatomic, strong) UIViewController     *currentVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    
    // 初始化第一个控制器
    self.firstVC   = [FirstViewController new];
    [self addChildViewController:self.firstVC];
    
    // 初始化第二个控制器
    self.secondVC = [SecondViewController new];
    [self addChildViewController:self.secondVC];
    
    // 加载第一个控制器的视图
    [self.firstVC didMoveToParentViewController:self];
    [self.contentView addSubview:self.firstVC.view];
    
    // 简易存储当前控制器
    self.currentVC = self.firstVC;
    
    // 创建出按钮
    [self createButtons];
}

- (void)createButtons {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 320, 80)];
    backView.tag     = kButtonsContentView;
    [self.view addSubview:backView];
    
    // 控制器1按钮
    [UIButton createButtonWithFrame:CGRectMake(10, 0, 145, 40)
                            withTag:kFirstViewController
                          withTitle:@"First"
                           withFont:nil
                          addTarget:self
                             action:@selector(buttonEvent:)
                         haveBorder:YES
                       insertInView:backView];
    
    // 控制器2按钮
    [UIButton createButtonWithFrame:CGRectMake(10 + 155, 0, 145, 40)
                            withTag:kSenondViewController
                          withTitle:@"Second"
                           withFont:nil
                          addTarget:self
                             action:@selector(buttonEvent:)
                         haveBorder:YES
                       insertInView:backView];
}

- (void)buttonEvent:(UIButton *)button {
    
    if (button.tag == kFirstViewController) {
        
        // 此句话必加(否则点击两次的话会报错)
        if ([self.currentVC isEqual:self.firstVC]) {
            
            return;
        }
        
        // 控制器转场
        [self transitionFromViewController:self.currentVC
                          toViewController:self.firstVC
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{
                                }  completion:^(BOOL finished) {
                                    
                                    self.currentVC = self.firstVC;
                                }];
        
    } else if (button.tag == kSenondViewController) {
        
        // 此句话必加(否则点击两次的话会报错)
        if ([self.currentVC isEqual:self.secondVC]) {
            
            return;
        }
        
        // 控制器转场
        [self transitionFromViewController:self.currentVC
                          toViewController:self.secondVC
                                  duration:0
                                   options:UIViewAnimationOptionTransitionNone
                                animations:^{
                                }  completion:^(BOOL finished) {
                                    
                                    self.currentVC = self.secondVC;
                                }];
    }
}

@end
