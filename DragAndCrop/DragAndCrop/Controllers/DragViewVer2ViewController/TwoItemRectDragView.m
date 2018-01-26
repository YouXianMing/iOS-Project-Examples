//
//  TwoItemRectDragView.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "TwoItemRectDragView.h"
#import "UIView+SetRect.h"

@interface TwoItemRectDragView () {
    
    CGFloat _innerViewWidth;
    CGFloat _innerViewHeight;
    CGFloat _gap;
}

@property (nonatomic, strong) UIView      *innerView;

@property (nonatomic, strong) UIView      *moveView_1;
@property (nonatomic, strong) UIView      *moveView_2;

@property (nonatomic, strong) UIImageView *imageView_1;
@property (nonatomic, strong) UIImageView *imageView_2;

@end

@implementation TwoItemRectDragView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.innerView = [[UIView alloc] init];
        [self.innerView showRandomColorOutline];
        [self addSubview:self.innerView];
        
        self.moveView_1 = [[UIView alloc] init];
        [self.moveView_1 showRandomColorOutline];
        [self addSubview:self.moveView_1];
        
        self.moveView_2 = [[UIView alloc] init];
        [self.moveView_2 showRandomColorOutline];
        [self addSubview:self.moveView_2];
        
        {
            UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.moveView_1 addGestureRecognizer:recognizer];
        }

        {
            UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            [self.moveView_2 addGestureRecognizer:recognizer];
        }
    }
    
    return self;
}

- (void)setupWithGap:(CGFloat)gap itemSize:(CGSize)itemSize startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    self.innerView.frame = CGRectInset(self.bounds, gap, gap);
    
    _innerViewWidth  = self.innerView.width;
    _innerViewHeight = self.innerView.height;
    _gap             = gap;
    
    self.moveView_1.viewSize = itemSize;
    self.moveView_2.viewSize = itemSize;
    
    self.moveView_1.center = CGPointMake(_innerViewWidth * startPoint.x + gap, _innerViewHeight * startPoint.y + gap);
    self.moveView_2.center = CGPointMake(_innerViewWidth * endPoint.x + gap,   _innerViewHeight * endPoint.y + gap);
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // 拖拽
    CGPoint translation = [recognizer translationInView:self];
    
    // 获取移动view的当前的中心点
    CGPoint currentViewCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                            recognizer.view.center.y + translation.y);
    
    // 控制x轴不出界
    if (currentViewCenter.x < _gap) {
        
        currentViewCenter.x = _gap;
        
    } else if (currentViewCenter.x > _gap + _innerViewWidth) {
        
        currentViewCenter.x = _gap + _innerViewWidth;
    }
    
    // 控制y轴不出界
    if (currentViewCenter.y < _gap) {
        
        currentViewCenter.y = _gap;
        
    } else if (currentViewCenter.y > _gap + _innerViewHeight) {
        
        currentViewCenter.y = _gap + _innerViewHeight;
    }
    
    // 更新dragView位置
    recognizer.view.center = currentViewCenter;
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {

        if (self.delegate && [self.delegate respondsToSelector:@selector(twoItemRectDragView:startPoint:endPoint:)]) {
            
            [self.delegate twoItemRectDragView:self
                                    startPoint:CGPointMake((self.moveView_1.centerX - _gap) / _innerViewWidth,
                                                           (self.moveView_1.centerY - _gap) / _innerViewHeight)
                                      endPoint:CGPointMake((self.moveView_2.centerX - _gap) / _innerViewWidth,
                                                           (self.moveView_2.centerY - _gap) / _innerViewHeight)];
        }
    }
}

@end
