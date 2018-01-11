//
//  DragAndResizeVer2ViewController.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "DragAndResizeVer2ViewController.h"

@interface DragAndResizeVer2ViewController () {
    
    UIView *_areaView;
    UIView *_dragView;
}

@end

@implementation DragAndResizeVer2ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 区域view
    _areaView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - 50.f, Width - 50.f)];
    _areaView.center = self.contentView.middlePoint;
    [_areaView showRandomColorOutline];
    [self.contentView addSubview:_areaView];
    
    // 拖拽view
    _dragView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_dragView showRandomColorOutlineAndBackgroundColor];
    [_areaView addSubview:_dragView];
    _dragView.right  = _areaView.width;
    _dragView.bottom = _areaView.height;
    
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
    
    // 更新dragView位置
    recognizer.view.center = currentViewCenter;
    [recognizer setTranslation:CGPointMake(0, 0) inView:_areaView];
    
    // 更新areaViewframe
    _areaView.frame = CGRectMake(_areaView.x, _areaView.y, recognizer.view.right, recognizer.view.bottom);
}

@end
