//
//  ViewController.m
//  DragView
//
//  Created by YouXianMing on 2017/12/27.
//  Copyright © 2017年 Techcode. All rights reserved.
//

#import "ViewController.h"
#import "UIView+DebugFrame.h"
#import "UIView+SetRect.h"

@interface ViewController () {
    
    UIView *_areaView;
    UIView *_dragView;
    
    UIView *_block_01_view;
}

@property (nonatomic,strong) UIDynamicAnimator * animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 区域view
    _areaView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - 50.f, Width - 50.f)];
    _areaView.center = self.view.center;
    [_areaView showRandomColorOutline];
    [self.view addSubview:_areaView];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_areaView];
    
    // 拖拽view
    _dragView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_dragView showRandomColorOutlineAndBackgroundColor];
    [_areaView addSubview:_dragView];
    
    // 阻碍
    _block_01_view        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _block_01_view.center = _areaView.middlePoint;
    [_block_01_view showRandomColorOutline];
    [_areaView addSubview:_block_01_view];
    
    // 给dragView添加拖拽手势
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [_dragView addGestureRecognizer:recognizer];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // 拖拽
    CGPoint translation = [recognizer translationInView:_areaView];
    
    // 获取移动view的当前的中心点
    CGPoint currentViewCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                            recognizer.view.center.y + translation.y);
    
    CGFloat halfWidth  = _dragView.width / 2.f;
    CGFloat halfHeight = _dragView.height / 2.f;
    CGRect rect        = CGRectMake(currentViewCenter.x - halfWidth,
                                    currentViewCenter.y - halfHeight,
                                    _dragView.width,
                                    _dragView.height);
    
    // block_01_view的边界检测
    {
        CGRect newRect = CGRectIntersection(rect, _block_01_view.frame);
        if (newRect.size.width || newRect.size.height) {
            
            if (newRect.size.width >= newRect.size.height) {
                
                if (newRect.origin.y == _block_01_view.y) {
                    
                    currentViewCenter.y -= newRect.size.height;
                    
                } else {
                    
                    currentViewCenter.y += newRect.size.height;
                }
                
            } else {
                
                if (newRect.origin.x == _block_01_view.x) {
                    
                    currentViewCenter.x -= newRect.size.width;
                    
                } else {
                    
                    currentViewCenter.x += newRect.size.width;
                }
            }
        }
    }
    
    // 控制x轴不出界
    if (currentViewCenter.x < _dragView.width / 2.f) {
        
        currentViewCenter.x = _dragView.width / 2.f;
        
    } else if (currentViewCenter.x > _areaView.width - _dragView.width / 2.f) {
        
        currentViewCenter.x = _areaView.width - _dragView.width / 2.f;
    }
    
    // 控制y轴不出界
    if (currentViewCenter.y < _dragView.height / 2.f) {
        
        currentViewCenter.y = _dragView.height / 2.f;
        
    } else if (currentViewCenter.y > _areaView.height - _dragView.height / 2.f) {
        
        currentViewCenter.y = _areaView.height - _dragView.height / 2.f;
    }
    
    recognizer.view.center = currentViewCenter;
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:_areaView];
    
    _dragView.center = recognizer.view.center;
}

@end
