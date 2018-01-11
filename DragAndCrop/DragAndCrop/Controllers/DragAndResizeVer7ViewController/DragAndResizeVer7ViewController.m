//
//  DragAndResizeVer7ViewController.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "DragAndResizeVer7ViewController.h"

@interface DragAndResizeVer7ViewController () {
    
    UIView *_areaView;
    UIView *_dragView;
}

@end

@implementation DragAndResizeVer7ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.contentView showRandomColorOutline];
    
    // 区域view
    CGFloat width    = Width - 50.f;
    _areaView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    _areaView.center = self.contentView.middlePoint;
    [_areaView showRandomColorOutline];
    [self.contentView addSubview:_areaView];
    
    // 拖拽view
    _dragView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50.f)];
    [_dragView showRandomColorOutlineAndBackgroundColor];
    [_areaView addSubview:_dragView];
    _dragView.right  = _areaView.width;
    _dragView.bottom = _areaView.height;
    
    // 给dragView添加拖拽手势
    UIPanGestureRecognizer *dragViewRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewHandlePan:)];
    [_dragView addGestureRecognizer:dragViewRecognizer];
    
    // 给areaView添加拖拽手势
    UIPanGestureRecognizer *areaViewRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(areaViewHandlePan:)];
    [_areaView addGestureRecognizer:areaViewRecognizer];
}

- (void)dragViewHandlePan:(UIPanGestureRecognizer *)recognizer {
    
    // 拖拽
    CGPoint translation = [recognizer translationInView:_areaView];
    
    // 获取移动view的当前的中心点
    CGPoint currentViewCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                            recognizer.view.center.y + translation.y);
    
    // 控制x轴不出界
    if (currentViewCenter.x < recognizer.view.width / 2.f) {
        
        currentViewCenter.x = recognizer.view.width / 2.f;
    }
    
    // 控制y轴不出界
    if (currentViewCenter.y < recognizer.view.height / 2.f) {
        
        currentViewCenter.y = recognizer.view.height / 2.f;
    }
    
    // 等比例 1:1
    currentViewCenter.x = currentViewCenter.y;
    
    // 控制拖拽不出x边界
    if (currentViewCenter.x + _areaView.x + recognizer.view.width / 2.f > self.contentView.width) {
        
        currentViewCenter.x = self.contentView.width - _areaView.x - recognizer.view.width / 2.f;
        currentViewCenter.y = currentViewCenter.x;
    }
    
    // 控制拖拽不出y边界
    if (currentViewCenter.y + _areaView.y + recognizer.view.height / 2.f > self.contentView.height) {
        
        currentViewCenter.y = self.contentView.height - _areaView.y - recognizer.view.height / 2.f;
        currentViewCenter.x = currentViewCenter.y;
    }
    
    // 更新dragView位置
    recognizer.view.center = currentViewCenter;
    [recognizer setTranslation:CGPointMake(0, 0) inView:_areaView];
    
    // 更新areaViewframe
    _areaView.frame = CGRectMake(_areaView.x, _areaView.y, recognizer.view.right, recognizer.view.bottom);
}

- (void)areaViewHandlePan:(UIPanGestureRecognizer *)recognizer {
    
    // 拖拽
    CGPoint translation = [recognizer translationInView:self.contentView];
    
    // 获取移动view的当前的中心点
    CGPoint currentViewCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                            recognizer.view.center.y + translation.y);
    
    // 控制x轴不出界
    if (currentViewCenter.x < recognizer.view.width / 2.f) {
        
        currentViewCenter.x = recognizer.view.width / 2.f;
        
    } else if (currentViewCenter.x > self.contentView.width - recognizer.view.width / 2.f) {
        
        currentViewCenter.x = self.contentView.width - recognizer.view.width / 2.f;
    }
    
    // 控制y轴不出界
    if (currentViewCenter.y < recognizer.view.height / 2.f) {
        
        currentViewCenter.y = recognizer.view.height / 2.f;
        
    } else if (currentViewCenter.y > self.contentView.height - recognizer.view.height / 2.f) {
        
        currentViewCenter.y = self.contentView.height - recognizer.view.height / 2.f;
    }
    
    // 更新dragView位置
    recognizer.view.center = currentViewCenter;
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.contentView];
}

@end
