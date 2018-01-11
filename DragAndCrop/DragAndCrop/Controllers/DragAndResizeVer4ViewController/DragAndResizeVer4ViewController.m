//
//  DragAndResizeVer4ViewController.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/11.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "DragAndResizeVer4ViewController.h"

@interface DragAndResizeVer4ViewController () {
    
    UIView *_areaView;
    UIView *_dragView;
}

@end

static CGFloat scale         = 2.f;
static CGFloat areaViewWidth = 0;

@implementation DragAndResizeVer4ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 区域view
    _areaView        = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width - 50.f, (Width - 50.f) / scale)];
    _areaView.center = self.contentView.middlePoint;
    areaViewWidth    = _areaView.width;
    [_areaView showRandomColorOutline];
    [self.contentView addSubview:_areaView];
    
    // 拖拽view
    _dragView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50.f)];
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
    
    // 限定不出界
    currentViewCenter.x = (currentViewCenter.y + recognizer.view.height / 2.f) * scale - recognizer.view.width / 2.f;
    if (currentViewCenter.x >= areaViewWidth - recognizer.view.width / 2.f) {
        
        currentViewCenter.x = areaViewWidth - recognizer.view.width / 2.f;
        currentViewCenter.y = (currentViewCenter.x + recognizer.view.width / 2.f) / scale - recognizer.view.height / 2.f;
    }
    
    CGFloat width  = 0;
    CGFloat height = 0;
    width          = currentViewCenter.x + recognizer.view.width / 2.f;
    height         = currentViewCenter.y + recognizer.view.height / 2.f;
    
    // 更新dragView位置
    recognizer.view.center = currentViewCenter;
    [recognizer setTranslation:CGPointMake(0, 0) inView:_areaView];
    
    _areaView.frame  = CGRectMake(_areaView.x, _areaView.y, width, height);
}

@end
