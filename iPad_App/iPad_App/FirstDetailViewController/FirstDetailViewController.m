//
//  FirstDetailViewController.m
//  iPad_App
//
//  Created by YouXianMing on 2017/10/23.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "FirstDetailViewController.h"
#import "UIViewController+DebugFrame.h"
#import "Masonry.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

static const NSInteger buttonTag = 1000;

@interface FirstDetailViewController () {
    
    UIView *_bottomView;
}

@property (nonatomic, strong) UIView                              *contentView;           // 用contentView来装载控制器的view
@property (nonatomic, strong) NSMutableArray <UIViewController *> *tabBarViewControllers; // 存储所有的控制器
@property (nonatomic, weak) UIViewController                      *selectedController;    // 存储当前显示的控制器

@end

@implementation FirstDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 控制器容器view
    self.contentView = [UIView new];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    // 创建控制器数组
    self.tabBarViewControllers = [NSMutableArray array];
    
    {
        UIViewController *controller = [FirstViewController new];
        [self.tabBarViewControllers addObject:controller];
    }
    
    {
        UIViewController *controller = [SecondViewController new];
        [self.tabBarViewControllers addObject:controller];
    }
    
    {
        UIViewController *controller = [ThirdViewController new];
        [self.tabBarViewControllers addObject:controller];
    }
    
    // 添加子控制器
    [self.tabBarViewControllers enumerateObjectsUsingBlock:^(UIViewController *controller, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self addChildViewController:controller];
    }];
    
    // 显示子控制器中的第一个控制器
    [self.childViewControllers.firstObject didMoveToParentViewController:self];
    [self.contentView addSubview:self.tabBarViewControllers.firstObject.view];
    
    // 更新第一个控制器view的约束,与contentView一致
    [self.tabBarViewControllers.firstObject.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.contentView);
    }];
    
    // 记录当前显示的控制器以及在数组中的编号
    self.selectedController = self.tabBarViewControllers.firstObject;
    
    // 添加底部按钮
    [self buildTabBarButtons];
    
    [self showDebugFrame];
}

- (void)buildTabBarButtons {
    
    UIView *bottomView         = [UIView new];
    bottomView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.15f];
    _bottomView                = bottomView;
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(75.f);
    }];
    
    [self.tabBarViewControllers enumerateObjectsUsingBlock:^(UIViewController *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 初始化button
        UIButton *button       = [UIButton new];
        button.tag             = buttonTag + idx;
        [button addTarget:self action:@selector(buttonsEvent:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        if (idx == 0) {
            
            button.selected = YES;
        }
        
        // button样式设置
        button.layer.borderWidth = 1.f;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.backgroundColor   = [[UIColor yellowColor] colorWithAlphaComponent:0.25f];
        button.titleLabel.font   = [UIFont systemFontOfSize:24.f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.25f] forState:UIControlStateNormal];
        [button setTitle:NSStringFromClass([obj class]) forState:UIControlStateNormal];
    }];
    
    if /* 如果只要一个控制器 */ (bottomView.subviews.count == 1) {
        
        [bottomView.subviews.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(bottomView);
        }];
        
    } /* 如果有两个控制器 */ else if (bottomView.subviews.count == 2) {
        
        [bottomView.subviews.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
            make.width.equalTo(bottomView.mas_width).multipliedBy(0.5);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(bottomView.subviews.lastObject.mas_left);
        }];
        
        [bottomView.subviews.lastObject mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            
            make.width.equalTo(bottomView.mas_width).multipliedBy(0.5);
            make.left.mas_equalTo(bottomView.subviews.firstObject.mas_right);
            make.right.mas_equalTo(0);
        }];
        
    } /* 如果超过了两个控制器 */ else if (bottomView.subviews.count >= 3) {
        
        [bottomView.subviews enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.width.equalTo(bottomView.mas_width).multipliedBy(1.0 / bottomView.subviews.count);
                
                if /* 第一个button */ (idx == 0) {
                    
                    make.left.mas_equalTo(0);
                    make.right.mas_equalTo(bottomView.subviews[idx + 1].mas_left);
                    
                } /* 最后一个button */ else if (idx == bottomView.subviews.count - 1) {
                    
                    make.left.mas_equalTo(bottomView.subviews[idx - 1].mas_right);
                    make.right.mas_equalTo(0);
                    
                } /* 中间的button */ else {
                    
                    make.left.mas_equalTo(bottomView.subviews[idx - 1].mas_right);
                    make.right.mas_equalTo(bottomView.subviews[idx + 1].mas_left);
                }
            }];
        }];
    }
}

- (void)buttonsEvent:(UIButton *)button {
    
    NSInteger controllerIndex = button.tag - buttonTag;
    
    if (self.selectedController == self.tabBarViewControllers[controllerIndex]) {
        
        return;
    }
    
    [_bottomView.subviews enumerateObjectsUsingBlock:^(UIButton *tmpButton, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([tmpButton isKindOfClass:[UIButton class]]) {

            tmpButton.selected = [button isEqual:tmpButton];
        }
    }];
    
    [self transitionFromViewController:self.selectedController
                      toViewController:self.tabBarViewControllers[controllerIndex]
                              duration:0.f
                               options:UIViewAnimationOptionTransitionNone
                            animations:nil
                            completion:^(BOOL finished) {
                                
                                self.selectedController = self.tabBarViewControllers[controllerIndex];
                                
                                // 重新更新当前控制器view的约束,与contentView一致
                                [self.selectedController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                                    
                                    make.edges.equalTo(self.contentView);
                                }];
                            }];
}

@end
