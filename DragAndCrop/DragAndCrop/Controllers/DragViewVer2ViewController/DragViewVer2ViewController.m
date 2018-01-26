//
//  DragViewVer2ViewController.m
//  DragAndCrop
//
//  Created by YouXianMing on 2018/1/25.
//  Copyright © 2018年 Techcode. All rights reserved.
//

#import "DragViewVer2ViewController.h"
#import "TwoItemRectDragView.h"
#import "TwoItemVtDragView.h"
#import "UIView+SetRect.h"
#import "UIView+DebugFrame.h"

@interface DragViewVer2ViewController () <TwoItemRectDragViewDelegate, TwoItemVtDragViewDelegate>

@end

@implementation DragViewVer2ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    TwoItemRectDragView *dragView = [[TwoItemRectDragView alloc] initWithFrame:CGRectMake(0, 0, Width - 50.f, Width - 200.f)];
    dragView.center               = self.contentView.middlePoint;
    dragView.delegate             = self;
    [dragView setupWithGap:25.f itemSize:CGSizeMake(40, 40) startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
    [self.contentView addSubview:dragView];
    
    TwoItemVtDragView *vtDragView = [[TwoItemVtDragView alloc] initWithFrame:CGRectMake(0, 0, 50, 200.f)];
    vtDragView.delegate           = self;
    [vtDragView setupWithGap:25.f itemSize:CGSizeMake(40, 40) startLocation:0.5f endLocation:0.75];
    [vtDragView showRandomColorOutline];
    [self.contentView addSubview:vtDragView];
    
    [dragView showRandomColorOutline];
}

- (void)twoItemRectDragView:(TwoItemRectDragView *)dragView startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    NSLog(@"start %@", NSStringFromCGPoint(startPoint));
    NSLog(@"end   %@", NSStringFromCGPoint(endPoint));
}

- (void)twoItemVtDragView:(TwoItemVtDragView *)dragView startLocation:(CGFloat)startLocation endLocation:(CGFloat)endLocation {
    
    NSLog(@"%f %f", startLocation, endLocation);
}

@end
