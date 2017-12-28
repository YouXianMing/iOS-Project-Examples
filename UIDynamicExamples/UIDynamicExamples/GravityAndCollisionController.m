//
//  GravityAndCollisionController.m
//  UIDynamicExamples
//
//  Created by YouXianMing on 2017/12/28.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "GravityAndCollisionController.h"

@interface GravityAndCollisionController ()

@property (nonatomic, strong) UIView            *contentView;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation GravityAndCollisionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 初始化view
    self.contentView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - 50.f, Height - StatusBarAndNavigationBarHeight - 50.f)];
    self.contentView.bottom  = self.view.height - 25.f;
    self.contentView.centerX = Width / 2.f;
    [self.contentView showOutlineWithColor:[UIColor blackColor]];
    [self.view addSubview:self.contentView];
    
    // 指定Dynamic发生的场所
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.contentView];
    
    // 测试重力的view
    UIView *view_01 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [view_01 showRandomColorOutlineAndBackgroundColor];
    [self.contentView addSubview:view_01];
    
    // 测试重力的view
    UIView *view_02 = [[UIView alloc] initWithFrame:CGRectMake(25, 75, 50, 50)];
    [view_02 showRandomColorOutlineAndBackgroundColor];
    [self.contentView addSubview:view_02];
    
    // 测试边界检测的view
    UIView *view_03 = [[UIView alloc] initWithFrame:CGRectMake(40.f, self.contentView.height - 100.f, 50, 50)];
    [view_03 showRandomColorOutlineAndBackgroundColor];
    [self.contentView addSubview:view_03];
    
    // 给指定的view设定重力行为并让重力行为在Dynamic发生场所生效
    {
        // 给指定的view设定重力行为
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[view_01, view_02]];
        
        // 使Dynamic发生场所添加重力行为并生效
        [self.animator addBehavior:gravity];
    }
    
    // 给指定的view设定边界碰撞行为并让边界碰撞行为在Dynamic发生场所生效
    {
        // 给指定的view设定边界碰撞行为
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[view_01, view_02, view_03]];
        
        // Dynamic发生场所触发边界碰撞
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        // 使Dynamic发生场所添加边界碰撞行为并生效
        [self.animator addBehavior:collision];
    }
}

@end

